part of 'product_cubit.dart';

@immutable
class ProductState {
  final List<ProductModel> products;
  // final List<ProductModel> warzywa = products.where((products.productGroup) => products.productGroup == 'Warzywa',).toList();

  const ProductState({
    required this.products,
  });
}
