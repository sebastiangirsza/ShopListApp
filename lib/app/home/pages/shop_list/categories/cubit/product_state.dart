part of 'product_cubit.dart';

@immutable
class ProductState {
  final List<ProductModel> products;

  const ProductState({
    required this.products,
  });
}

@immutable
class AddState {
  const AddState();
}
