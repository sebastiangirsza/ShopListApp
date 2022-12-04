import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';

part 'add_product_price_state.dart';

@injectable
class AddProductPriceCubit extends Cubit<AddProductPriceState> {
  AddProductPriceCubit(
    this._productPriceRepository,
    this._shopRepository,
  ) : super(const AddProductPriceState());

  final ProductPriceRepository _productPriceRepository;
  StreamSubscription? _streamSubscription;
  final ShopRepository _shopRepository;

  Future<void> updateProductPrice(
    double productPrice,
    String id,
    // String downloadURL,
    // String shopDownloadURL,
  ) async {
    try {
      await _productPriceRepository.updateProductPrice(
        productPrice,
        id,
        // downloadURL,
        // shopDownloadURL,
      );
      emit(
        const AddProductPriceState(
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        AddProductPriceState(
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> addFirstProductPrice(
    String productName,
  ) async {
    try {
      _streamSubscription = _shopRepository.getShopsStream().listen(
        (shops) {
          for (final shop in shops) {
            _productPriceRepository.addFirstProductPrice(
              productName,
              0,
              shop.shopName,
              // DateTime.now(),
            );
          }
        },
      );
    } catch (error) {
      emit(
        AddProductPriceState(
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
