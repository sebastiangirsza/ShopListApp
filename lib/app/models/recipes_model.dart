import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesModel {
  final String recipesName;
  final String recipesProductName;
  final String recipesMakeing;

  RecipesModel({
    required this.recipesName,
    required this.recipesProductName,
    required this.recipesMakeing,
  });

  RecipesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> recipes)
      : recipesName = recipes['recipes_name'],
        recipesProductName = recipes['recipes_product_name'],
        recipesMakeing = recipes['recipes_makeing'];
}
