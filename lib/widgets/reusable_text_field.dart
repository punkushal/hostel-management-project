import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField({
    super.key,
    required this.controller,
    this.hintText,
    required this.label,
    required this.radiusValue,
    this.keyboardType,
    this.validator,
  });
  final TextEditingController controller;
  final String? hintText;
  final Widget label;
  final double radiusValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintText,
          label: label,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent)),
    );
  }
}
