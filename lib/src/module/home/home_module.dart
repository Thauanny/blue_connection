import 'package:blue_connection/config/bluetooth_config/bluetooth_controller.dart';
import 'package:blue_connection/src/module/home/presentation/pages/initial_page/initial_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/bloc/home_bloc.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => HomeBloc(i<BluetoothController>())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const InitialPage()),
      ];
}
