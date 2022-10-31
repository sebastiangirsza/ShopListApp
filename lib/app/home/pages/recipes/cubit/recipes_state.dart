part of 'recipes_cubit.dart';

@immutable
class RecipesState {
  final List<RecipesModel> recipes;
  final Status status;

  const RecipesState({
    required this.recipes,
    this.status = Status.initial,
  });
}
