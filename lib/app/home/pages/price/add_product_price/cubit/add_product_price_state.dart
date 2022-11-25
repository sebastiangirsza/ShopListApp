part of 'add_product_price_cubit.dart';

@immutable
class AddProductPriceState {
  const AddProductPriceState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}
