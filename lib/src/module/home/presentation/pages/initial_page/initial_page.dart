import 'dart:async';

import 'package:blue_connection/src/module/home/presentation/bloc/home_event.dart';
import 'package:blue_connection/src/module/home/presentation/pages/bonded_device_page/bonded_devices_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_state.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final HomeBloc homeBloc = Modular.get<HomeBloc>();
  late StreamSubscription _subscription;
  @override
  void initState() {
    _subscription = homeBloc.stream.listen(_stateListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  homeBloc.add(HomeEvent.enabledBluetooth());
                },
                child: const Text('Request Enabled'))
          ],
        ),
      ),
    );
  }
}

_stateListener(HomeState state) => state.maybeWhen(
      sucessEnabledBluetooth: () {
        Modular.to.push(
          MaterialPageRoute(builder: (context) => const BondedDevicePage()),
        );
      },
      error: () {
        print('error');
      },
      orElse: () => {},
    );
