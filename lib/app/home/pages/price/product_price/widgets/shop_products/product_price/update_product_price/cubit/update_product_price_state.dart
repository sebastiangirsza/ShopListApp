part of 'update_product_price_cubit.dart';

@immutable
class UpdateProductPriceState {
  const UpdateProductPriceState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
}
