part of 'add_shop_product_cubit.dart';

@immutable
class AddShopProductsState {
  final bool saved;
  final String errorMessage;
  final List<ShopModel> shops;
  final List<ShopProductsModel> shopProducts;
  final List<String> shopProductsNames;
  const AddShopProductsState({
    this.saved = false,
    this.errorMessage = '',
    required this.shops,
    required this.shopProducts,
    this.shopProductsNames = const [],
  });
}
