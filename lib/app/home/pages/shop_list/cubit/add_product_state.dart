part of 'add_product_cubit.dart';

@immutable
class AddProductState {
  final List<ShopProductsModel> shopProducts;
  final bool saved;
  const AddProductState({
    this.shopProducts = const [],
    this.saved = false,
  });
}
