import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/models/product_model.dart';
import 'package:shoplistapp/app/repositories/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productsRepository)
      : super(const ProductState(products: []));

  StreamSubscription? _streamSubscription;

  final ProductsRepository _productsRepository;

  Future<void> products({required String productGroup}) async {
    _streamSubscription =
        _productsRepository.getProductsStream(productGroup).listen((products) {
      emit(ProductState(products: products));
    });
  }

  Future<void> productsQuantity({required String productGroup}) async {
    _streamSubscription = _productsRepository
        .getProductsQuantityStream(productGroup)
        .listen((products) {
      emit(ProductState(products: products));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
