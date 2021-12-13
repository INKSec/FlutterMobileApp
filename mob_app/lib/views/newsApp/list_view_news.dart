import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/newsApp/article_model.dart';
import 'package:hexcolor/hexcolor.dart';

// Oberfläche der ListView News
Widget listViewNews(Article article) {
  return Container(
    // äußere Box für Inhalt
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      // Artikelbox Hintergrund
      color: HexColor("AFFC41"),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container für die Überschrift der News
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: HexColor("AFFC41"),
          ),
          child: Text(
            article.source.name,
            style: TextStyle(
                // Farbe Überschrift
                color: HexColor("#3C1642"),
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
        ),
        const SizedBox(
          height: 6.0,
        ),
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
          height: 6.0,
        ),

        const SizedBox(
          height: 8.0,
        ),
        Text(
          article.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              // Unterer Text Farbe
              color: HexColor("##3C1642")),
        )
      ],
    ),
  );
}
