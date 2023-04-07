import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class optionWidget extends StatelessWidget {
  final String svgSource;
  final String optionTitle;
  final VoidCallback press;
  const optionWidget({
    Key? key,
    required this.svgSource,
    required this.optionTitle, 
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        //padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  SvgPicture.asset(svgSource),
                  Spacer(),
                  Text(
                    optionTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(
                      fontSize: 20,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}