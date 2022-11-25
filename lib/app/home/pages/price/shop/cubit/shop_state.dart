part of 'shop_cubit.dart';

@immutable
class ShopState {
  const ShopState({
    required this.shops,
  });
  final List<ShopModel> shops;
}
