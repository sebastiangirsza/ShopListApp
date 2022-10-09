part of 'recipe_details_cubit.dart';

@immutable
class RecipeDetailsState {
  final List<PurchasedProductModel> purchasedProducts;
  const RecipeDetailsState({this.purchasedProducts = const []});
}
