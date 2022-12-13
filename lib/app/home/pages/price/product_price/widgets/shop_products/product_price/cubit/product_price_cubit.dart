import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/core/enums.dart';
import 'package:shoplistapp/app/models/product_price_model.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';

part 'product_price_state.dart';

@injectable
class ProductPriceCubit extends Cubit<ProductPriceState> {
  ProductPriceCubit(
    this._productPriceRepository,
    this._shopRepository,
  ) : super(const ProductPriceState(
          productsPrice: [],
          status: Status.initial,
        ));

  StreamSubscription? _streamSubscription;

  final ProductPriceRepository _productPriceRepository;
  final ShopRepository _shopRepository;

  Future<void> getProductPriceStream(
    String productName,
  ) async {
    emit(const ProductPriceState(
      productsPrice: [],
      status: Status.loading,
    ));
    _streamSubscription = _productPriceRepository
        .getProductPriceStream(
      productName,
    )
        .listen(
      (productsPrice) async {
        for (final productPrice in productsPrice) {
          _shopRepository
              .getShopsLogoStream(productPrice.shopName)
              .listen((shops) {
            for (final shop in shops) {
              productsPrice[productsPrice
                      .indexWhere((element) => element.id == productPrice.id)] =
                  productPrice.copyWith(shopLogo: shop.downloadURL);
            }
          });
        }
        emit(ProductPriceState(
          productsPrice: productsPrice,
          status: Status.success,
        ));
      },
    )..onError(
        (error) {
          emit(
              const ProductPriceState(productsPrice: [], status: Status.error));
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
