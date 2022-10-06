import 'package:ShopListApp/app/repositories/recipes_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit() : super(RecipesState());
}

class AddRecipesCubit extends Cubit<AddRecipesState> {
  AddRecipesCubit(this._recipesRepository)
      : super(
          const AddRecipesState(),
        );

  final RecipesRepository _recipesRepository;

  Future<void> add(
    String recipesName,
    String recipesProductName,
    String recipesMakeing,
  ) async {
    try {
      await _recipesRepository.add(
        recipesName,
        recipesProductName,
        recipesMakeing,
      );
      emit(const AddRecipesState());
    } catch (error) {
      null;
    }
  }
}
