import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shoplistapp/app/repositories/recipes_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';

part 'add_recipes_state.dart';

class AddRecipesCubit extends Cubit<AddRecipesState> {
  AddRecipesCubit(this._recipesRepository, this._userRepository)
      : super(
          const AddRecipesState(),
        );

  final RecipesRepository _recipesRepository;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final UserRespository _userRepository;

  Future<void> add(
    String recipesName,
    String recipesProductName,
    String recipesMakeing,
    String imageName,
    String downloadURL,
  ) async {
    try {
      await _recipesRepository.add(
        recipesName,
        recipesProductName,
        recipesMakeing,
        imageName,
        downloadURL,
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
    final user = await _userRepository.getUserID();
    final userID = user!.uid;
    File file = File(filePath);

    try {
      await storage.ref('$userID/recipes/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      FirebaseException(message: e.toString(), plugin: '');
    }
  }
}
