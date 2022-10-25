import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/models/product_model.dart';
import 'package:shoplistapp/app/repositories/products_repositories.dart';

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

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

class AddCubit extends Cubit<AddState> {
  AddCubit(this._productsRepository)
      : super(
          const AddState(),
        );

  final ProductsRepository _productsRepository;

  Future<void> add(
    String productGroup,
    String productName,
    int productQuantity,
    bool isChecked,
    String productTypeName,
  ) async {
    try {
      await _productsRepository.add(
        productGroup,
        productName,
        productQuantity,
        isChecked,
        productTypeName,
      );
      emit(const AddState());
    } catch (error) {
      null;
    }
  }

  Future<void> isChecked({
    required bool isChecked,
    required String documentID,
  }) async {
    try {
      await _productsRepository.isChecked(
        isChecked,
        documentID,
      );
      emit(const AddState());
    } catch (error) {
      null;
    }
  }

  Future<void> delete({required String documentID}) {
    return _productsRepository.delete(id: documentID);
  }
}
