// To parse this JSON data, do
//
//     final categoryClass = categoryClassFromJson(jsonString);

import 'dart:convert';

List<CategoryClass> categoryClassFromJson(String str) => List<CategoryClass>.from(json.decode(str).map((x) => CategoryClass.fromJson(x)));

String categoryClassToJson(List<CategoryClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryClass {
    CategoryClass({
        this.id,
        this.category,
    });

    int id;
    String category;

    factory CategoryClass.fromJson(Map<String, dynamic> json) => CategoryClass(
        id: json["id"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
    };
}
