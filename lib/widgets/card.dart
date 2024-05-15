import 'package:flutter/material.dart';

//To reuse card widget make card design for needed uis
class CardDesign extends StatelessWidget {
  const CardDesign({
    super.key,
    required this.content,
    required this.elevation,
    required this.radiusValue,
    required this.margin,
    required this.color,
  });
  final Widget content;
  final double elevation;
  final double radiusValue;
  final EdgeInsetsGeometry margin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusValue),
      ),
      child: content,
    );
  }
}
