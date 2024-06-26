import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField({
    super.key,
    this.controller,
    this.hintText,
    required this.radiusValue,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    required this.labelText,
    required this.obsecureText,
    this.suffixIcon,
  });
  final TextEditingController? controller;
  final String? hintText;

  final double radiusValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String labelText;
  final bool obsecureText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          suffix: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade200),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent)),
    );
  }
}
