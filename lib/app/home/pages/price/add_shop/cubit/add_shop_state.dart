part of 'add_shop_cubit.dart';

@immutable
class AddShopState {
  final bool saved;
  final String errorMessage;
  const AddShopState({
    this.saved = false,
    this.errorMessage = '',
  });
}
