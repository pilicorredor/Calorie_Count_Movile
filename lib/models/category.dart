import 'dart:convert';

Category categoryFromJson(String str) =>
    Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int? id;
  String name;
  String imageUrl;

  Category({
     this.id,
     this.name = '',
     this.imageUrl = '',
  });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "imageUrl": imageUrl,
  };
}
