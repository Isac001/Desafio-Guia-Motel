import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  // Define the icon
  final IconData icon;

  // Define the color
  final Color? color;

  // Define the size
  final double? size;

  const IconWidget({
    super.key,
    required this.icon,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? Colors.white,
      size: size ?? 24,
    );
  }
}
