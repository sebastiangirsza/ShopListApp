import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/product_price_model.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';

part 'product_price_state.dart';

@injectable
class ProductPriceCubit extends Cubit<ProductPriceState> {
  ProductPriceCubit(this._productPriceRepository)
      : super(const ProductPriceState(productPrice: []));

  StreamSubscription? _streamSubscription;
  final ProductPriceRepository _productPriceRepository;

  Future<void> start() async {
    _streamSubscription =
        _productPriceRepository.getProductPriceStream().listen(
      (productPrice) {
        emit(ProductPriceState(productPrice: productPrice));
      },
    )..onError(
            (error) {
              emit(const ProductPriceState(productPrice: []));
            },
          );
  }

  Future<void> shopName(String shopName) async {
    _streamSubscription = _productPriceRepository.getShopName(shopName).listen(
      (productPrice) {
        emit(ProductPriceState(productPrice: productPrice));
      },
    )..onError(
        (error) {
          emit(const ProductPriceState(productPrice: []));
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
