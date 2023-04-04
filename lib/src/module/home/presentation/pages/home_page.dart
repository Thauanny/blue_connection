import 'package:blue_connection/config/bluetooth_config/bluetooth_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  BluetoothConfig bluetoothConfig = BluetoothConfig.instance;
  //TODO move to bloc
  final int _deviceState = -1;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      //TODO change to bloc
      setState(() {
        bluetoothConfig.bluetoothState = state;
      });
    });

    //TODO change to bloc
    bluetoothConfig.requestEnable();
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        bluetoothConfig.bluetoothState = state;
      });
    });
  }

  @override
  void dispose() {
    bluetoothConfig.disposeBluetoth();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Switch(
                  value: bluetoothConfig.isEnabled,
                  onChanged: (bool value) async {
                    if (value) {
                      // Enable Bluetooth
                      await bluetoothConfig.requestEnable();
                    } else {
                      // Disable Bluetooth
                      await bluetoothConfig.requestDisable();
                    }
                    setState(() {});
                  },
                )
              ],
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Texto',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
