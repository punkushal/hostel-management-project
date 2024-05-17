import 'package:flutter/material.dart';

class ReusableText extends StatelessWidget {
  const ReusableText(
      {super.key,
      required this.text,
      this.textAlign,
      this.textOverflow,
      this.fontWeight,
      this.color,
      this.fontSize,
      required this.textStyle});

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
    );
  }
}
