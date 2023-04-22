import '../../home/data/models/joystick_item.dart';
import 'dart:math' as math;

double calculatePositionXOfButton(
    {required int index,
    required double innerCircleSize,
    required double actualSize,
    required List<PadButtonItem?> buttons,
    required double? buttonsPadding}) {
  double degrees = 360 / buttons.length * index;
  double lastAngleRadians = (degrees) * (math.pi / 180.0);

  var rBig = actualSize / 2;
  var rSmall = (innerCircleSize + 2 * buttonsPadding!) / 2;

  return (rBig - rSmall) + (rBig - rSmall) * math.cos(lastAngleRadians);
}

double calculatePositionYOfButton(
    {required int index,
    required double innerCircleSize,
    required double actualSize,
    required List<PadButtonItem?> buttons,
    required double? buttonsPadding}) {
  double degrees = 360 / buttons.length * index;
  double lastAngleRadians = (degrees) * (math.pi / 180.0);
  var rBig = actualSize / 2;
  var rSmall = (innerCircleSize + 2 * buttonsPadding!) / 2;

  return (rBig - rSmall) + (rBig - rSmall) * math.sin(lastAngleRadians);
}
