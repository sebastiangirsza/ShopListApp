part of 'product_cubit.dart';

@immutable
class ProductState {
  final List<ProductModel> products;
  final List<ProductPriceModel> productsPrice;

  const ProductState({
    required this.products,
    required this.productsPrice,
  });
}
