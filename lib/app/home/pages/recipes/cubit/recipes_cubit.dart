import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/core/enums.dart';
import 'package:shoplistapp/app/models/recipes_model.dart';
import 'package:shoplistapp/app/repositories/recipes_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';

part 'recipes_state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  RecipesCubit(this._recipesRepository, this._userRepository)
      : super(const RecipesState(
          recipes: [],
          status: Status.initial,
        ));

  StreamSubscription? _streamSubscription;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final RecipesRepository _recipesRepository;
  final UserRespository _userRepository;

  Future<void> recipes() async {
    emit(const RecipesState(
      recipes: [],
      status: Status.loading,
    ));
    final user = await _userRepository.getUserID();
    final userID = user!.uid;
    try {
      _streamSubscription = _recipesRepository.getRecipesStream().listen(
        (recipes) async {
          for (final recipe in recipes) {
            try {
              final yourDownloadURL = await storage
                  .ref('$userID/recipes/${recipe.imageName}')
                  .getDownloadURL();
              recipes[recipes.indexWhere(
                (element) => element.id == recipe.id,
              )] = recipe.copyWith(
                downloadURL: yourDownloadURL,
              );
            } catch (e) {
              FirebaseException(message: e.toString(), plugin: '');
            }
          }
          emit(
            RecipesState(
              recipes: recipes,
              status: Status.success,
            ),
          );
        },
      );
    } catch (error) {
      emit(
        const RecipesState(
          recipes: [],
          status: Status.error,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
