import 'package:flutter/material.dart';

class CircleView extends StatelessWidget {
  final double size;
  final double iconSize;

  final Color color;

  final IconData buttonIcon;

  final VoidCallback onTap;

  const CircleView({
    super.key,
    required this.iconSize,
    required this.size,
    required this.color,
    required this.buttonIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          buttonIcon,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
