part of 'shop_products_cubit.dart';

@immutable
class ShopProductsState {
  const ShopProductsState({
    required this.shopProducts,
  });
  final List<ShopProductsModel> shopProducts;
}
