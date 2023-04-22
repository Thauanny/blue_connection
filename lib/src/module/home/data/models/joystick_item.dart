import 'package:flutter/material.dart';

class PadButtonItem {
  final int index;

  final IconData buttonIcon;

  final Color backgroundColor;

  final double size;

  const PadButtonItem({
    required this.size,
    required this.index,
    required this.buttonIcon,
    required this.backgroundColor,
  });
}
