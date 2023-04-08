import 'package:calmly_app/components.dart/textField.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class passwordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const passwordField({
    super.key, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return textField(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

