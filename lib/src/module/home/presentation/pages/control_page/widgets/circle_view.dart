import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleView extends StatelessWidget {
  final double size;

  final Color color;

  final List<BoxShadow> boxShadow;

  final Border border;

  late Image? buttonImage;

  late Icon? buttonIcon;

  late String? buttonText;

  CircleView({
    required this.size,
    this.color = Colors.transparent,
    required this.boxShadow,
    required this.border,
    buttonImage,
    buttonIcon,
    buttonText,
  }) {
    this.buttonImage = buttonImage;
    this.buttonIcon = buttonIcon;
    this.buttonText = buttonText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: buttonIcon ??
            ((buttonImage != null)
                ? buttonImage
                : (buttonText != null)
                    ? Text(buttonText!)
                    : null),
      ),
    );
  }

  factory CircleView.joystickCircle(double? size, Color? color) => CircleView(
        size: size ?? 40,
        color: color ?? Colors.black,
        border: Border.all(
          color: Colors.black45,
          width: 4.0,
          style: BorderStyle.solid,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );

  factory CircleView.joystickInnerCircle(double? size, Color? color) =>
      CircleView(
        size: size ?? 40,
        color: color ?? Colors.black,
        border: Border.all(
          color: Colors.black26,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );

  factory CircleView.padBackgroundCircle(double? size, Color? backgroundColour,
          borderColor, Color? shadowColor,
          {double? opacity}) =>
      CircleView(
        size: size ?? 40,
        color: backgroundColour ?? Colors.black,
        border: Border.all(
          color: borderColor,
          width: 4.0,
          style: BorderStyle.solid,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor ?? Colors.amber,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );

  factory CircleView.padButtonCircle(
    double? size,
    Color? color,
    Image? image,
    Icon? icon,
    String? text,
  ) =>
      CircleView(
        size: size ?? 40,
        color: color ?? Colors.black,
        buttonImage: image,
        buttonIcon: icon,
        buttonText: text,
        border: Border.all(
          color: Colors.black26,
          width: 2.0,
          style: BorderStyle.solid,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 8.0,
            blurRadius: 8.0,
          )
        ],
      );
}
