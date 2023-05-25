import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class searchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const searchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "search",
          icon: SvgPicture.asset("assets/icons/search.svg"),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
