import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/navigation_drawer.dart';
import 'package:mob_app/views/newsApp/api_service.dart';
import 'package:mob_app/views/newsApp/list_view_news.dart';
import 'package:hexcolor/hexcolor.dart';
import 'article_model.dart';

// ignore: must_be_immutable
class Artikel extends StatelessWidget {
  Artikel({Key? key}) : super(key: key);
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false)
              ? const BackButton()
              : null, // Backbutton
          title: Text(
            'Fußballnews',
            style: TextStyle(color: HexColor("3C1642")),
          ),

          centerTitle: true,
          // Hintergrund Header
          backgroundColor: HexColor("#ADD8E6"),
        ),
        body: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article>? articles = snapshot.data;
              return ListView.builder(
                itemCount: articles!.length,
                itemBuilder: (context, index) => listViewNews(articles[index]),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // Hintergrundfarbe Komplett
        backgroundColor: HexColor("#ADD8E6"),
      );
}

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
