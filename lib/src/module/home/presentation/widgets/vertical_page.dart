import 'package:blue_connection/config/bluetooth_config/bluetooth_status.dart';
import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/home/domain/entities/blue_device.dart';
import 'package:blue_connection/src/module/home/presentation/controller/home_page_controller.dart';
import 'package:flutter/material.dart';

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key});

  @override
  State<VerticalPage> createState() => _VerticalPageState();
}

class _VerticalPageState extends State<VerticalPage> {
  Device? _device;
  HomePageController controller = HomePageController();

  @override
  void initState() {
    super.initState();
    controller.requestEnable();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              //TODO SUBSTITUIR POR CUBIR/BLOC
              ValueListenableBuilder(
                valueListenable: controller.bluetoothStatus,
                builder: (context, status, child) {
                  return Switch(
                    value: controller.bluetoothStatus.value.isEnabled,
                    onChanged: (bool value) {
                      if (value) {
                        controller.requestEnable();
                      } else {
                        controller.requestDisable();
                      }
                    },
                  );
                },
              ), //TODO SUBSTITUIR POR CUBIR/BLOC
              ValueListenableBuilder(
                valueListenable: controller.devices,
                builder: (context, deviceList, child) {
                  return DropdownButton(
                    hint: const Text('Selecione'),
                    items: controller.getDeviceItems(deviceList),
                    onChanged: (value) {
                      _device = value;
                      setState(() {
                        //TODO RETIRAR
                      });
                    },
                    value: deviceList.isNotEmpty ? _device : null,
                  );
                },
              ),
            ],
          ),
          ValueListenableBuilder(
              valueListenable: controller.deviceStatus,
              builder: (context, status, child) {
                return ElevatedButton(
                  onPressed: !status.isConected
                      ? () {
                          controller.connectDevice(_device);
                        }
                      : () {
                          controller.disconnectDevice();
                        },
                  child: Text(status.name),
                );
              }),
        ],
      ),
    );
  }
}
