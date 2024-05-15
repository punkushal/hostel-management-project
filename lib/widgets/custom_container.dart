import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.bgColor,
    required this.radiusValue,
    required this.content,
  });
  final double? width;
  final double? height;
  final Color? bgColor;
  final double radiusValue;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radiusValue),
        ),
        border: Border.all(width: 0.5, color: Colors.black),
      ),
      child: content,
    );
  }
}
