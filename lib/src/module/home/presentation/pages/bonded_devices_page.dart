import 'dart:async';

import 'package:blue_connection/src/module/home/presentation/pages/control_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/presentation/widgets/loading_modal.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class BondedDevicePage extends StatefulWidget {
  const BondedDevicePage({super.key});

  @override
  State<BondedDevicePage> createState() => _BondedState();
}

class _BondedState extends State<BondedDevicePage> {
  final HomeBloc homeBloc = Modular.get<HomeBloc>();
  late StreamSubscription _subscription;
  @override
  void initState() {
    _subscription = homeBloc.stream.listen(_stateListener);
    homeBloc.add(HomeEvent.requestBondedDevices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          return homeBloc.bondedDevices.isNotEmpty
              ? Center(
                  child: ListView(
                    children: List.generate(
                      homeBloc.bondedDevices.length,
                      (index) => ListTile(
                        leading: const Icon(Icons.bluetooth_audio),
                        title: Text(homeBloc.bondedDevices[index].name),
                        trailing: const Icon(Icons.more_vert),
                        onTap: () {
                          Modular.to.push(
                            MaterialPageRoute(
                              builder: (context) => ControlPage(
                                device: homeBloc.bondedDevices[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : state != HomeState.loading()
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.close),
                          Text('Nenhum Dispositivo Encontrado'),
                        ],
                      ),
                    )
                  : const LoadingModal();
        },
      ),
    );
  }

  _stateListener(HomeState state) => state.maybeWhen(
        loading: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const LoadingModal(),
            isDismissible: false,
          );
        },
        sucessBondedDevices: () {
          Modular.to.pop();
          if (homeBloc.bondedDevices.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Dispositivos Encontrados: ${homeBloc.bondedDevices.length}'),
                backgroundColor: Colors.green[600],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Nenhum dispositivo Encontrado'),
                backgroundColor: Colors.yellow[600],
              ),
            );
          }
        },
        error: () {
          print('error');
        },
        orElse: () => {},
      );
}
