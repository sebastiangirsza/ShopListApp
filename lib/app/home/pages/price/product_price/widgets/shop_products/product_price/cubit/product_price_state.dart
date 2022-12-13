part of 'product_price_cubit.dart';

@immutable
class ProductPriceState {
  const ProductPriceState({
    required this.productsPrice,
    this.status = Status.initial,
  });

  final List<ProductPriceModel> productsPrice;
  final Status status;
}
