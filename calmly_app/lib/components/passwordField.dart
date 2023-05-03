import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class passwordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  
  const passwordField({
    Key? key,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return textField(
      child: TextField(
        controller: controller,
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
