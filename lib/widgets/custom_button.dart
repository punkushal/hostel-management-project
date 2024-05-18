import 'package:flutter/material.dart';
import 'package:hostel_management_project/widgets/custom_container.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.width,
      this.height,
      this.bgColor,
      required this.radiusValue,
      required this.content,
      this.onTap});
  final double? width;
  final double? height;
  final Color? bgColor;
  final double radiusValue;
  final Widget content;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        width: width,
        height: height,
        radiusValue: radiusValue,
        bgColor: bgColor,
        content: content,
      ),
    );
  }
}
