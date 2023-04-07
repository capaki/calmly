import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class navBarWidget extends StatelessWidget {
  const navBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          navBarItem(
            navTitle: "today",
            svgSource: "assets/icons/calendar.svg",
            press: () {},
          ),
          navBarItem(
            navTitle: "home page",
            svgSource: "assets/icons/gym.svg",
            press: () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            isActive: true,
          ),
          navBarItem(
            navTitle: "settings",
            svgSource: "assets/icons/Settings.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class navBarItem extends StatelessWidget {
  final String svgSource;
  final String navTitle;
  final VoidCallback press;
  final bool isActive;
  const navBarItem({
    super.key, 
    required this.svgSource, 
    required this.navTitle, 
    required this.press, 
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              isActive ? kActiveIconColor : kTextColor,
              BlendMode.srcIn,
            ),
            child: SvgPicture.asset(svgSource),
          ),
          Text(
            navTitle,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}

