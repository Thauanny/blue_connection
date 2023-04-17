import 'dart:math';
import '../../home/data/models/joystick_item.dart';

double calculatePositionXOfButton(int index, double innerCircleSize,
    double actualSize, List<JoyStickItem> buttons) {
  double degrees = 360 / buttons.length * index;
  double lastAngleRadians = (degrees) * (pi / 180.0);

  var rBig = actualSize / 2;
  var rSmall = (innerCircleSize + 2) / 2;

  return (rBig - rSmall) + (rBig - rSmall) * cos(lastAngleRadians);
}

double calculatePositionYOfButton(int index, double innerCircleSize,
    double actualSize, List<JoyStickItem> buttons) {
  double degrees = 360 / buttons.length * index;
  double lastAngleRadians = (degrees) * (pi / 180.0);
  var rBig = actualSize / 2;
  var rSmall = (innerCircleSize + 2) / 2;

  return (rBig - rSmall) + (rBig - rSmall) * sin(lastAngleRadians);
}
