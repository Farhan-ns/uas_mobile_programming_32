import 'package:flutter/material.dart';

class CTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final OutlineInputBorder border;
  final Function()? onTap;
  bool obscureText;
  bool enabled;

  CTextField(this.label, this.controller,
      {this.obscureText = false,
      this.enabled = true,
      this.onTap,
      this.border = const OutlineInputBorder()});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onTap: onTap,
      enabled: enabled,
      decoration: InputDecoration(labelText: label, border: border),
    );
  }
}
