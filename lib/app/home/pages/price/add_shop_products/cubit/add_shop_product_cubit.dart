import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';

part 'add_shop_product_state.dart';

@injectable
class AddShopProductsCubit extends Cubit<AddShopProductsState> {
  AddShopProductsCubit(
    this._shopProductsRepository,
    this._productPriceRepository,
    this._shopRepository,
  ) : super(const AddShopProductsState());

  final ShopProductsRepository _shopProductsRepository;
  final ProductPriceRepository _productPriceRepository;
  StreamSubscription? _streamSubscription;
  final ShopRepository _shopRepository;

  Future<void> addShopProduct(
    String shopProductName,
    String productGroup,
  ) async {
    try {
      await _shopProductsRepository.addShopProduct(
        shopProductName,
        productGroup,
      );
      _streamSubscription = _shopRepository.getShopsStream().listen(
        (shops) {
          for (final shop in shops) {
            _productPriceRepository.addFirstProductPrice(
              shopProductName,
              999999999999999,
              shop.downloadURL,
            );
          }
        },
      );
      emit(
        const AddShopProductsState(
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        AddShopProductsState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
