import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/models/purchased_product_model.dart';
import 'package:shoplistapp/app/repositories/recipes_products_repository.dart';

part 'recipe_details_state.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  RecipeDetailsCubit(this._recipesProductsRepository)
      : super(
          const RecipeDetailsState(),
        );

  StreamSubscription? _streamSubscription;

  final RecipesProductsRepository _recipesProductsRepository;

  Future<void> start({required String searchKey}) async {
    _streamSubscription = _recipesProductsRepository
        .getRecipesProductsStream(searchKey)
        .listen((purchasedProduct) {
      emit(RecipeDetailsState(purchasedProducts: purchasedProduct));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
