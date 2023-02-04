import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/product_model.dart';
import 'package:shoplistapp/app/models/product_price_model.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/product_repository.dart';

part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productsRepository, this._productPriceRepository)
      : super(const ProductState(
          products: [],
          productsPrice: [],
        ));

  StreamSubscription? _streamSubscription;

  final ProductsRepository _productsRepository;

  Future<void> products({required String productGroup}) async {
    _streamSubscription =
        _productsRepository.getProductsStream(productGroup).listen((products) {
      emit(ProductState(
        products: products,
        productsPrice: [],
      ));
    });
  }

  final ProductPriceRepository _productPriceRepository;

  Future<void> getProductLowestPriceStream(
    String productName,
  ) async {
    _streamSubscription = _productPriceRepository
        .getProductPriceStream(
      productName,
    )
        .listen(
      (productsPrice) {
        emit(ProductState(
          products: [],
          productsPrice: productsPrice,
        ));
      },
    )..onError(
        (error) {
          emit(const ProductState(
            products: [],
            productsPrice: [],
          ));
        },
      );
  }

  Future<void> productsQuantity({required String productGroup}) async {
    _streamSubscription = _productsRepository
        .getProductsQuantityStream(productGroup)
        .listen((products) {
      emit(ProductState(
        products: products,
        productsPrice: [],
      ));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
