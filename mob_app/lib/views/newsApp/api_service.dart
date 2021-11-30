import 'dart:convert';

import 'package:http/http.dart';
import 'package:mob_app/views/newsApp/article_model.dart';

// API Key
class ApiService {
  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=de&category=sport&apiKey=1fbe600cd16d4118b8919313a7e1f183"; // football evtl. wieder durch Sport ersetzen

// HTTP request

  Future<List<Article>> getArticle() async {
    Response res = await get(endPointUrl);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

// Holt die Artikel aus json und packt sie in eine Liste
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("HTTP request fehlgeschlagen");
    }
  }
}
