import 'package:flutter/material.dart';
import 'package:mob_app/views/newsApp/article_model.dart';

// Oberfläche der ListView News
Widget listViewNews(Article article) {
  return Container(
    // äußere Box für Inhalt
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: const [
          // Schatten der größeren Box
          BoxShadow(
            color: Colors.yellow,
            blurRadius: 3.0,
          )
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container für Bild
        Container(
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        // Container für die Überschrift der News
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            article.source.name,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        )
      ],
    ),
  );
}
