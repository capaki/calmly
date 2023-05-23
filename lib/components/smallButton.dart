import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class smallButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback press;
  final Color buttonColor, titleColor;
  const smallButton({
    super.key,
    required this.buttonTitle,
    required this.press,
    this.buttonColor = kPrimaryColor,
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.3, // Reduce the width for a smaller button
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Reduce padding for a smaller button
            ),
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
          onPressed: press,
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: titleColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
