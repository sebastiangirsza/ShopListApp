import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:shoplistapp/app/repositories/recipes_repository.dart';
import 'package:shoplistapp/app/repositories/storage_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';

part 'add_recipes_state.dart';

class AddRecipesCubit extends Cubit<AddRecipesState> {
  AddRecipesCubit(
    this._recipesRepository,
    this._userRepository,
    this._storageRepository,
  ) : super(
          const AddRecipesState(),
        );

  final RecipesRepository _recipesRepository;
  final UserRespository _userRepository;
  final StorageRepository _storageRepository;

  Future<void> addRecipe(
    String recipesName,
    String recipesProductName,
    String recipesMakeing,
    String imageName,
    String downloadURL,
    String filePath,
    String fileName,
  ) async {
    final user = await _userRepository.getUserID();
    final userID = user!.uid;
    File file = File(filePath);
    try {
      await _storageRepository.putFile(userID, fileName, file);
      await _recipesRepository.add(
        recipesName,
        recipesProductName,
        recipesMakeing,
        imageName,
        downloadURL,
      );

      // await Future.delayed(Duration(seconds: 3));

      emit(const AddRecipesState(saved: true));
    } catch (error) {
      print(error.toString());
    }
  }
}

//   Future<void> uploadFile(
//     String filePath,
//     String fileName,
//   ) async {
//     final user = await _userRepository.getUserID();
//     final userID = user!.uid;
//     File file = File(filePath);

//     try {
//       await storage.ref('$userID/recipes/$fileName').putFile(file);
//     } on firebase_core.FirebaseException catch (e) {
//       FirebaseException(message: e.toString(), plugin: '');
//     }
//   }
// }
