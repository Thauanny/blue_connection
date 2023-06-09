import 'package:blue_connection/src/module/home/presentation/pages/control_page/horizontal_page.dart';
import 'package:blue_connection/src/module/home/presentation/pages/control_page/vertical_page.dart';
import 'package:blue_connection/src/module/shared/domain/entities/blue_device.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key, required this.device});

  final Device device;

  @override
  State<ControlPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? VerticalPage(
                  device: widget.device,
                )
              : const HorizontalPage();
        },
      ),
    );
  }
}
