import 'package:calorie_counter/models/category_model.dart';

class CategoryList {
  List<CategoryModel> catList = [
    CategoryModel(
        id: 1, categoryName: 'Frutas', color: '#087802', icon: 'Icon_apple'),
    CategoryModel(
        id: 2, categoryName: 'Verduras', color: '##3f9bfc', icon: 'Icon_grass'),
    CategoryModel(
        id: 3, categoryName: 'Postres', color: '#ff8605', icon: 'Icon_cake'),
  ];

  List<CategoryModel> getAllCategories() {
    return catList;
  }

  int getLenghtCategories() {
    return catList.length;
  }

  List<String> getAllNamesCategories() {
    return catList.map((category) => category.categoryName).toList();
  }
}
