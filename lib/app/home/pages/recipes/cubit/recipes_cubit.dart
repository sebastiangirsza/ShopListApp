import 'dart:async';

import 'package:ShopListApp/app/models/recipes_model.dart';
import 'package:ShopListApp/app/repositories/recipes_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit(this._recipesRepository)
      : super(const RecipesState(recipes: []));

  StreamSubscription? _streamSubscription;

  final RecipesRepository _recipesRepository;

  Future<void> recipes() async {
    _streamSubscription =
        _recipesRepository.getRecipesStream().listen((recipes) {
      emit(RecipesState(recipes: recipes));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

class RecipesImagesCubit extends Cubit<RecipesImagesState> {
  RecipesImagesCubit() : super(const RecipesImagesState(downloadURL: ''));

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> downloadURL(String fileName) async {
    try {
      final downloadURL =
          await storage.ref('recipes/$fileName').getDownloadURL();
      emit(RecipesImagesState(downloadURL: downloadURL));
    } catch (e) {
      emit(const RecipesImagesState(downloadURL: ''));
    }
  }
}
