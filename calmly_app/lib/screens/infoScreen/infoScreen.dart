import 'package:calmly_app/components/navBar.dart';
import 'package:calmly_app/components/searchBar.dart';
import 'package:calmly_app/constants.dart';
import 'package:calmly_app/screens/infoScreen/components/articleScreen.dart';
import 'package:calmly_app/screens/infoScreen/components/infoArticle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class infoScreen extends StatefulWidget {
  @override
  _infoScreenState createState() => _infoScreenState();
}

class _infoScreenState extends State<infoScreen> {
  String searchQuery = '';

  Future<List<Widget>> allArticles(BuildContext context) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Widget> articles = [];

  QuerySnapshot querySnapshot = await _firestore.collection('articles').get();
  List<DocumentSnapshot> sortedDocuments = querySnapshot.docs.toList()
    ..sort((a, b) {
      var aData = a.data() as Map<String, dynamic>;
      var bData = b.data() as Map<String, dynamic>;
      return (aData['key'] as String).compareTo(bData['key'] as String);
    });

  for (DocumentSnapshot documentSnapshot in sortedDocuments) {
    final data = documentSnapshot.data() as Map<String, dynamic>;
    articles.add(
      infoArticle(
        articleTitle: data.containsKey('title') ? data['title'] : '',
        articleDetail: data.containsKey('detail') ? data['detail'] : '',
        articleKey: documentSnapshot.id,
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return articleScreen(
                  articleKey: documentSnapshot.id,
                  articleTitle: data.containsKey('title') ? data['title'] : '',
                  articleContent: data.containsKey('content') ? data['content'] : '',
                );
              },
            ),
          );
        },
      ),
    );
  }
  return articles;
}



  Widget getFilteredArticles(BuildContext context) {
    return FutureBuilder(
      future: allArticles(context),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Wrap(
            runSpacing: 15,
            children: snapshot.data!.where((article) {
              infoArticle infoArt = article as infoArticle;
              return infoArt.articleTitle.toLowerCase().contains(searchQuery.toLowerCase());
            }).toList(),
          );
        }
      },
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: navBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: kInfoColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      "get informed",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "get to know your mind better",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: Text(
                        "dive deep into the complex parts of the human brain. learn how your brain functions under various emotions such as stress, anxiety, happiness etc",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8F8F8F),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: searchBar(
                        onChanged: updateSearchQuery,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getFilteredArticles(context),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
