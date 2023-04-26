import 'package:calmly_app/constants.dart';
import 'package:calmly_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class navBar extends StatelessWidget {
  const navBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, //spaceBetween
        children: <Widget>[
          navBarItem(
            navTitle: "calendar",
            svgSource: "assets/icons/calendar.svg",
            press: () {},
          ),
          navBarItem(
            navTitle: "home",
            svgSource: "assets/icons/home.svg",
            press: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context){
                  return HomePage();
                }),
              );
            },
            isActive: true,
          ),
          navBarItem(
            navTitle: "profile",
            svgSource: "assets/icons/profile.svg",
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
              isActive ? kPrimaryColor : kTextColor,
              BlendMode.srcIn,
            ),
            child: SizedBox(
              width: 30,
              height: 30, 
              child: SvgPicture.asset(svgSource),
            ),
          ),
          Text(
            navTitle,
            style: TextStyle(color: isActive ? kPrimaryColor : kTextColor),
          ),
        ],
      ),
    );
  }
}

