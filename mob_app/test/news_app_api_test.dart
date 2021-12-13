import 'package:flutter_test/flutter_test.dart';
import 'package:mob_app/views/newsApp/api_service.dart';
import 'package:mob_app/views/newsApp/article_model.dart';

ApiService getAPIService() {
  return ApiService();
}

Future getArticles() {
  return getAPIService().getArticle();
}

void main() {
  group("NewsApp API tests", () {
    test("News should be a list of Articles", () async {
      final articles = await getArticles();
      expect(articles, isA<List<Article>>());
    });
  });
}
