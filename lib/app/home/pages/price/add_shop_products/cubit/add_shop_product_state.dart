part of 'add_shop_product_cubit.dart';

@immutable
class AddShopProductsState {
  final bool saved;
  final String errorMessage;
  const AddShopProductsState({
    this.saved = false,
    this.errorMessage = '',
  });
}
