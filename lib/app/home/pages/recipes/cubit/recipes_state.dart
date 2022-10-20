part of 'recipes_cubit.dart';

@immutable
class RecipesState {
  final List<RecipesModel> recipes;

  const RecipesState({required this.recipes});
}

@immutable
class RecipesImagesState {
  final String downloadURL;

  const RecipesImagesState({required this.downloadURL});
}
