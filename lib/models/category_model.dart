import 'dart:convert';

CategoryModel featuresModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String featuresModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.id,
    this.categoryName = '',
    this.color = '#baf748',
    this.icon = 'ad_rounded',
  });

  int? id;
  String categoryName;
  String color;
  String icon;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        categoryName: json["category"],
        color: json["color"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": categoryName,
        "color": color,
        "icon": icon,
      };
}
