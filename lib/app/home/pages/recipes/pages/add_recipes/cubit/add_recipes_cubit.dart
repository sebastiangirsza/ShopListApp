import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shoplistapp/app/repositories/recipes_repository.dart';

part 'add_recipes_state.dart';

class AddRecipesCubit extends Cubit<AddRecipesState> {
  AddRecipesCubit(this._recipesRepository)
      : super(
          const AddRecipesState(),
        );

  final RecipesRepository _recipesRepository;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> add(
    String recipesName,
    String recipesProductName,
    String recipesMakeing,
    String imageName,
  ) async {
    try {
      await _recipesRepository.add(
        recipesName,
        recipesProductName,
        recipesMakeing,
        imageName,
      );
      emit(const AddRecipesState(saved: true));
    } catch (error) {
      null;
    }
  }

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);

    try {
      await storage.ref('recipes/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      FirebaseException(message: e.toString(), plugin: '');
    }
  }
}
