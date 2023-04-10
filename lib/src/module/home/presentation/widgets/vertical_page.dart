import 'package:blue_connection/config/bluetooth_config/bluetooth_controller.dart';
import 'package:blue_connection/config/bluetooth_config/bluetooth_status.dart';
import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/home/domain/entities/blue_device.dart';
import 'package:blue_connection/src/module/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'circular_button.dart';

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key});

  @override
  State<VerticalPage> createState() => _VerticalPageState();
}

class _VerticalPageState extends State<VerticalPage> {
  final HomeBloc homeBloc = Modular.get<HomeBloc>();
  Device? _device;

  @override
  void initState() {
    super.initState();
    homeBloc.add(HomeRequestEnableBluetooth());
  }

  @override
  void dispose() {
    homeBloc.add(HomeRequestBluetoothDispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                //TODO SUBSTITUIR POR CUBIR/BLOC

                BlocBuilder<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  builder: (context, state) {
                    return Switch(
                      value: homeBloc
                          .bluetoothController.bluetoothStatus.isEnabled,
                      onChanged: (bool value) {
                        if (value) {
                          homeBloc.add(HomeRequestEnableBluetooth());
                        } else {
                          homeBloc.add(HomeRequesDisableBluetooth());
                        }
                      },
                    );
                  },
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  builder: (context, state) {
                    return DropdownButton(
                      hint: const Text('Selecione'),
                      items: getDeviceItems(homeBloc.bondedDevices),
                      onChanged: (value) {
                        _device = value;
                      },
                      value: homeBloc.bondedDevices.isNotEmpty ? _device : null,
                    );
                  },
                )
              ],
            ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: homeBloc,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: !homeBloc
                          .bluetoothController.deviceStatus.isConected
                      ? () {
                          homeBloc
                              .add(HomeRequestConnectDevice(device: _device));
                        }
                      : () {
                          homeBloc.add(HomeRequestDisconnetDevice());
                        },
                  child: Text(homeBloc.bluetoothController.deviceStatus.name),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //todo: verificar tamanho
                    CircularButton(
                      height: 100,
                      width: 100,
                      onTap: () {},
                      icon: Icons.keyboard_arrow_up_rounded,
                      backgroundColor: Colors.green,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularButton(
                          height: 100,
                          width: 100,
                          onTap: () {},
                          icon: Icons.keyboard_arrow_left_rounded,
                          backgroundColor: Colors.red,
                        ),
                        CircularButton(
                          height: 100,
                          width: 100,
                          onTap: () {},
                          icon: Icons.keyboard_arrow_right_rounded,
                          backgroundColor: Colors.blue,
                        ),
                      ],
                    ),
                    CircularButton(
                      height: 100,
                      width: 100,
                      onTap: () {},
                      icon: Icons.keyboard_arrow_down_rounded,
                      backgroundColor: Colors.yellow[700]!,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<Device>> getDeviceItems(List<Device> deviceList) {
  List<DropdownMenuItem<Device>> items = [];

  if (deviceList.isEmpty) {
    items.add(
      const DropdownMenuItem(
        child: Text('Selecione'),
      ),
    );
  } else {
    for (var device in deviceList) {
      items.add(DropdownMenuItem(
        value: device,
        child: Text(device.name),
      ));
    }
  }
  return items;
}
