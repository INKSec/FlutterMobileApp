import 'package:mob_app/views/newsApp/article_model.dart';
import 'package:mob_app/views/newsApp/news_api.dart';
import 'package:test/test.dart';

void main() {
  group("Article Model", () {
    test("should be able to create an article", () {
      final article = Article(
        source: Source(id: "test_provider", name: "test"),
        author: "flutter",
        title: "Test Title",
        description: "Test Description",
        url: "https://www.google.com",
        urlToImage: "https://www.google.com",
        publishedAt: DateTime.now().toString(),
        content: "Test Content",
      );

      expect(article.title, "Test Title");
      expect(article.description, "Test Description");
      expect(article.url, "https://www.google.com");
      expect(article.urlToImage, "https://www.google.com");
      expect(article.publishedAt, isNotNull);
      expect(article.content, "Test Content");
      expect(article.source.id, "test_provider");
      expect(article.author, "flutter");
      expect(article.source.name, "test");
    });

    test("should be able to create an article from a JSON document", () {
      final json = {
        "source": {"id": "test_provider", "name": "test"},
        "author": "flutter",
        "title": "Test Title",
        "description": "Test Description",
        "url": "https://www.google.com",
        "urlToImage": "https://www.google.com",
        "publishedAt": DateTime.now().toString(),
        "content": "Test Content"
      };

      final article = Article.fromJson(json);

      expect(article.title, "Test Title");
      expect(article.description, "Test Description");
      expect(article.url, "https://www.google.com");
      expect(article.urlToImage, "https://www.google.com");
      expect(article.publishedAt, isNotNull);
      expect(article.content, "Test Content");
      expect(article.source.id, "test_provider");
      expect(article.author, "flutter");
      expect(article.source.name, "test");
    });
  });
}
