import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/core/enums.dart';
import 'package:shoplistapp/app/models/recipes_model.dart';
import 'package:shoplistapp/app/repositories/recipes_repository.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit(this._recipesRepository)
      : super(const RecipesState(recipes: []));

  StreamSubscription? _streamSubscription;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final RecipesRepository _recipesRepository;

  Future<void> recipes() async {
    _streamSubscription =
        _recipesRepository.getRecipesStream().listen((recipes) async {
      emit(RecipesState(recipes: recipes));
      for (final recipe in recipes) {
        try {
          final yourDownloadURL =
              await storage.ref('recipes/${recipe.imageName}').getDownloadURL();
          recipes[recipes.indexWhere((element) => element.id == recipe.id)] =
              recipe.copyWith(downloadURL: yourDownloadURL);
        } catch (e) {
          FirebaseException(message: e.toString(), plugin: '');
        }
      }
      emit(RecipesState(recipes: recipes));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
