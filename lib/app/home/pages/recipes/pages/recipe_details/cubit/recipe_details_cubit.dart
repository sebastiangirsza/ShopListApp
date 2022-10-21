import 'dart:async';
import 'package:ShopListApp/app/repositories/recipes_products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ShopListApp/app/models/purchased_product_model.dart';

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
