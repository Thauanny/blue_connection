import 'dart:async';

import 'package:blue_connection/config/bluetooth_config/device_status.dart';
import 'package:blue_connection/src/module/Configuration/presentation/pages/config_page.dart';
import 'package:blue_connection/src/module/shared/domain/entities/blue_device.dart';
import 'package:blue_connection/src/module/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../bloc/home_state.dart';
import 'circular_button.dart';

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key});

  @override
  State<VerticalPage> createState() => _VerticalPageState();
}

class _VerticalPageState extends State<VerticalPage> {
  final HomeBloc homeBloc = Modular.get<HomeBloc>();
  late StreamSubscription _subscription;
  Device? _device;

  @override
  void initState() {
    super.initState();

    _subscription = homeBloc.stream.listen(_stateListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              Modular.to.push(
                MaterialPageRoute(builder: (context) => const ConfigPage()),
              );
            },
            icon: const Icon(Icons.settings))
      ]),
      body: Center(
        child: Column(
          children: <Widget>[
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

_stateListener(HomeState state) => state.maybeWhen(orElse: () => {});
