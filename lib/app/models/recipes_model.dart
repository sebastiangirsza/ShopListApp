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

  RecipesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> products)
      : recipesName = products['recipes_name'],
        recipesProductName = products['recipes_product_name'],
        recipesMakeing = products['recipes_makeing'];
}
