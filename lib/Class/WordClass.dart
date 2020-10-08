// To parse this JSON data, do
//
//     final wordClass = wordClassFromJson(jsonString);

import 'dart:convert';

List<WordClass> wordClassFromJson(String str) => List<WordClass>.from(json.decode(str).map((x) => WordClass.fromJson(x)));

String wordClassToJson(List<WordClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WordClass {
    WordClass({
        this.id,
        this.word,
        this.points,
        this.category,
    });

    int id;
    String word;
    double points;
    Category category;

    factory WordClass.fromJson(Map<String, dynamic> json) => WordClass(
        id: json["id"],
        word: json["word"],
        points: json["points"],
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "word": word,
        "points": points,
        "category": category.toJson(),
    };
}

class Category {
    Category({
        this.id,
        this.category,
    });

    int id;
    String category;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
    };
}
