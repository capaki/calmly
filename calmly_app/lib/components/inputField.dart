import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class inputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const inputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: kPrimaryColor,
        ),
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
