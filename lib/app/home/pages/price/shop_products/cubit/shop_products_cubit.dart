import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';
part 'shop_products_state.dart';

@injectable
class ShopProductsCubit extends Cubit<ShopProductsState> {
  ShopProductsCubit(
    this._shopProductsRepository,
  ) : super(const ShopProductsState(shopProducts: []));

  StreamSubscription? _streamSubscription;
  final ShopProductsRepository _shopProductsRepository;

  Future<void> start() async {
    _streamSubscription =
        _shopProductsRepository.getShopProductsStream().listen(
      (shopProducts) {
        emit(ShopProductsState(
          shopProducts: shopProducts,
        ));
      },
    )..onError(
            (error) {
              emit(const ShopProductsState(
                shopProducts: [],
              ));
            },
          );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
