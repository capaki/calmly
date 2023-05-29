import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class passwordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  const passwordField({
    Key? key,
    required this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  _passwordFieldState createState() => _passwordFieldState();
}

class _passwordFieldState extends State<passwordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return textField(
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: "password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: kPrimaryColor,
            ),
            onPressed: _togglePasswordVisibility,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
