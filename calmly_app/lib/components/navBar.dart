import 'package:calmly_app/constants.dart';
import 'package:calmly_app/main.dart';
import 'package:calmly_app/screens/calendarScreen/calendarScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:calmly_app/screens/profileScreen/profileScreen.dart';

class navBar extends StatelessWidget {
  const navBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: navBarItem(
              navTitle: "calendar",
              svgSource: "assets/icons/calendar-days.svg",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return calendarScreen();
                  }),
                );
              },
            ),
          ),
          Expanded(
            child: navBarItem(
              navTitle: "home",
              svgSource: "assets/icons/home.svg",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }),
                );
              },
              isActive: true,
            ),
          ),
          Expanded(
            child: navBarItem(
              navTitle: "profile",
              svgSource: "assets/icons/profile.svg",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return profileScreen();
                  }),
                );
              },
            ),
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
    Key? key,
    required this.svgSource,
    required this.navTitle,
    required this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: 30,
            height: 30,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                isActive ? kPrimaryColor : kTextColor,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(svgSource),
            ),
          ),
          Text(
            navTitle,
            style: TextStyle(
              color: isActive ? kPrimaryColor : kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
