import 'package:blue_connection/config/bluetooth_config/bluetooth_status.dart';
import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/home/domain/entities/blue_device.dart';
import 'package:blue_connection/src/module/home/presentation/controller/home_page_controller.dart';
import 'package:flutter/material.dart';

import 'circular_button.dart';

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
            },
          ),
          Padding(
            padding: const EdgeInsets.all(36),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
