import 'package:calmly_app/components.dart/background.dart';
import 'package:calmly_app/components.dart/button.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return mainBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "welcome",
              style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF817DC0),
                  shadows: [
                    Shadow(
                      color: Color(0xFF6F35A5),
                      offset: Offset(2, 2),
                      blurRadius: 2,
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            mainButton(
              buttonTitle: "LOGIN",
              press: () {},
            ),
            mainButton(
              buttonTitle: "SIGN UP",
              buttonColor: kPrimaryLightColor,
              titleColor: Colors.black,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

