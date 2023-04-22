import 'package:blue_connection/src/module/home/data/models/joystick_item.dart';
import 'package:blue_connection/src/module/shared/utils/joystick_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'circle_view.dart';

class PadButtonsView extends StatelessWidget {
  final double size;

  final List<PadButtonItem> buttons;

  final double? buttonsPadding;

  const PadButtonsView({
    super.key,
    required this.size,
    required this.buttons,
    this.buttonsPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    double? actualSize = size;
    0.5;
    double innerCircleSize = actualSize / 3;

    return Stack(
      children: createButtons(innerCircleSize, actualSize),
    );
  }

  List<Widget> createButtons(double innerCircleSize, double actualSize) {
    List<Widget> list = [];
    list.add(
      Container(
        width: actualSize,
        height: actualSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
    );

    for (var i = 0; i < buttons.length; i++) {
      var padButton = buttons[i];
      list.add(createPositionedButtons(
        padButton,
        actualSize,
        i,
        innerCircleSize,
      ));
    }
    return list;
  }

  Positioned createPositionedButtons(
    PadButtonItem paddButton,
    double actualSize,
    int index,
    double innerCircleSize,
  ) {
    return Positioned(
      top: calculatePositionYOfButton(
        index: index,
        innerCircleSize: innerCircleSize,
        actualSize: actualSize,
        buttons: buttons,
        buttonsPadding: buttonsPadding,
      ),
      left: calculatePositionXOfButton(
        index: index,
        innerCircleSize: innerCircleSize,
        actualSize: actualSize,
        buttons: buttons,
        buttonsPadding: buttonsPadding,
      ),
      child: Padding(
        padding: EdgeInsets.all(buttonsPadding!),
        child: CircleView(
          iconSize: paddButton.size,
          onTap: () {
            debugPrint(" ${[paddButton.index]}");
          },
          size: innerCircleSize,
          color: paddButton.backgroundColor,
          buttonIcon: paddButton.buttonIcon,
        ),
      ),
    );
  }
}
