import 'package:ShopListApp/app/repositories/recipes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_recipes_state.dart';

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
