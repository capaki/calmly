import 'package:flutter/material.dart';

class forgotPasswordBackground extends StatelessWidget {
  final Widget child;
  const forgotPasswordBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 60,
            left: 10,
            child: Transform.scale(
              scale: 1.2,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Color(0xFF696969)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
