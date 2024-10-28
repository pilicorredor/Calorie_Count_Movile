import 'package:calorie_counter/models/category_model.dart';

class CategoryList {
  List<CategoryModel> catList = [
    CategoryModel(categoryName: 'Frutas', color: '#087802', icon: 'Icon_apple'),
    CategoryModel(
        categoryName: 'Verduras', color: '##3f9bfc', icon: 'Icon_grass'),
    CategoryModel(categoryName: 'Postres', color: '#ff8605', icon: 'Icon_cake'),
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
