import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  final Widget child;
  const textField({
    super.key, 
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(30)
      ),
      child: child,
    );
  }
}

