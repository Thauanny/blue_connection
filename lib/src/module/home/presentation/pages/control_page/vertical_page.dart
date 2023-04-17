import 'dart:async';
import 'package:blue_connection/src/module/home/data/models/joystick_item.dart';
import 'package:blue_connection/src/module/shared/domain/entities/blue_device.dart';
import 'package:blue_connection/src/module/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/joystick.dart';

class VerticalPage extends StatefulWidget {
  const VerticalPage({super.key, required this.device});
  final Device device;
  @override
  State<VerticalPage> createState() => _VerticalPageState();
}

class _VerticalPageState extends State<VerticalPage> {
  final HomeBloc homeBloc = Modular.get<HomeBloc>();
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.indigo[900],
        title: Text(
          widget.device.name,
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: PadButtonsView(buttonsPadding: 0, size: 250),
            )),
      ),
    );
  }
}
