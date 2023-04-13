import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class infoArticle extends StatelessWidget {
  final String articleTitle;
  final String articleDetail;
  final VoidCallback press;
  const infoArticle({
    super.key, 
    required this.articleTitle,
    required this.articleDetail,
    required this.press, 
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        //padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 23,
              spreadRadius: -20,
            )
          ]
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: Row(
                children: <Widget>[
                  /*Container(
                    height: 42,
                    width: 43,
                    decoration: BoxDecoration(
                      color: isCompleted ? Colors.white : kActiveIconColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: kActiveIconColor),
                    ),
                    child: Icon(
                      Icons.book, 
                      color: isCompleted ? kActiveIconColor : Colors.white,
                    ),
                  ),*/
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          articleTitle,
                          style: Theme.of(context)
                          .textTheme.titleMedium!
                          .copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kArticle,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          articleDetail,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                fontSize: 15,
                                color: Color(0xFF8F8F8F),
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: press,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Color(0xFFB2B2B2)
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