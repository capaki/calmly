import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class socialMedia extends StatelessWidget {
  final String iconPath;
  final VoidCallback press;
  const socialMedia({
    super.key, 
    required this.iconPath, 
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconPath,
          height: 20,
          width: 20,
          colorFilter: ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}

