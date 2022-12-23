import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_model.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';

part 'add_shop_product_state.dart';

@injectable
class AddShopProductsCubit extends Cubit<AddShopProductsState> {
  AddShopProductsCubit(
    this._shopRepository,
    this._shopProductsRepository,
    this._productPriceRepository,
  ) : super(const AddShopProductsState(
          shops: [],
          shopProducts: [],
        ));

  final ShopRepository _shopRepository;
  final ShopProductsRepository _shopProductsRepository;
  final ProductPriceRepository _productPriceRepository;
  StreamSubscription? _streamSubscription;

  Future<void> getShopProductsStream() async {
    _streamSubscription =
        _shopProductsRepository.getShopProductsStream().listen(
      (shopProducts) {
        final List<String> shopProductsNames = shopProducts
            .map((element) => element.shopProductName.toLowerCase())
            .toList();
        emit(AddShopProductsState(
          shops: const [],
          shopProducts: shopProducts,
          shopProductsNames: shopProductsNames,
        ));
      },
    )..onError(
            (error) {
              emit(const AddShopProductsState(
                shops: [],
                shopProducts: [],
              ));
            },
          );
  }

  Future<void> getShopsStream() async {
    _streamSubscription = _shopRepository.getShopsStream().listen(
      (shops) {
        emit(AddShopProductsState(
          shops: shops,
          shopProducts: const [],
        ));
      },
    )..onError(
        (error) {
          emit(const AddShopProductsState(
            shops: [],
            shopProducts: [],
          ));
        },
      );
  }

  Future<void> addShopProduct(
    String shopProductName,
    String productGroup,
    String svgIcon,
  ) async {
    final shopsModels = state.shops;
    final List<String> shopDownloadURLs =
        shopsModels.map((element) => element.downloadURL).toList();
    try {
      await _shopProductsRepository.addShopProduct(
        shopProductName,
        productGroup,
        svgIcon,
      );
      for (final shopDownloadURL in shopDownloadURLs) {
        await _productPriceRepository.addFirstProductPrice(
          shopProductName,
          999999999999999,
          shopDownloadURL,
        );
      }

      emit(
        const AddShopProductsState(
          saved: true,
          shops: [],
          shopProducts: [],
        ),
      );
    } catch (error) {
      emit(
        AddShopProductsState(
          errorMessage: error.toString(),
          shops: const [],
          shopProducts: const [],
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
