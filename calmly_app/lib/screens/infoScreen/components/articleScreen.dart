import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:flutter/material.dart';

class articleScreen extends StatelessWidget {
  final String articleKey;
  final String articleTitle;
  final String articleContent;

  articleScreen({required this.articleKey, required this.articleTitle, required this.articleContent});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: size.height * 0.7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/welcome.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 10,
                  child: Transform.scale(
                    scale: 1.1,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Color(0xFF696969)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45, bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Text(
                          articleTitle,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: kArticle,
                              ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                articleContent,
                                style: TextStyle(fontSize: 17, color: Color(0xFF696969)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}