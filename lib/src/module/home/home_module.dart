import 'package:blue_connection/src/module/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => const HomePage(title: 'Home Page')),
      ];
}