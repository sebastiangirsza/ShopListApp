import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';

part 'add_shop_product_state.dart';

@injectable
class AddShopProductsCubit extends Cubit<AddShopProductsState> {
  AddShopProductsCubit(
    this._shopProductsRepository,
    this._productPriceRepository,
  ) : super(const AddShopProductsState());

  final ShopProductsRepository _shopProductsRepository;
  final ProductPriceRepository _productPriceRepository;
  StreamSubscription? _streamSubscription;

  Future<void> addShopProduct(
    String shopProductName,
    String productGroup,
    String svgIcon,
  ) async {
    try {
      _shopProductsRepository.addShopProduct(
        shopProductName,
        productGroup,
        svgIcon,
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

  Future<void> addFirstProductPrice(
    String shopProductName,
    String shopName,
  ) async {
    try {
      _productPriceRepository.addFirstProductPrice(
        shopProductName,
        999999999999999,
        'downloadURL',
        shopName,
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
