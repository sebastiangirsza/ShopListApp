import 'package:cloud_firestore/cloud_firestore.dart';

class RecipesModel {
  final String recipesName;
  final String recipesProductName;
  final String recipesMakeing;
  final String imageName;
  final String downloadURL;
  final String id;

  RecipesModel({
    required this.recipesName,
    required this.recipesProductName,
    required this.recipesMakeing,
    required this.imageName,
    required this.downloadURL,
    required this.id,
  });

  RecipesModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> recipes)
      : recipesName = recipes['recipes_name'],
        recipesProductName = recipes['recipes_product_name'],
        recipesMakeing = recipes['recipes_makeing'],
        imageName = recipes['image_name'],
        downloadURL = recipes['download_url'],
        id = recipes.id;

  RecipesModel copyWith({required String downloadURL}) => RecipesModel(
      recipesName: recipesName,
      recipesProductName: recipesProductName,
      recipesMakeing: recipesMakeing,
      imageName: imageName,
      downloadURL: downloadURL,
      id: id);
}
