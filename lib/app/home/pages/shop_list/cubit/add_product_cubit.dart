import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';
import 'package:shoplistapp/app/repositories/product_repository.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';

part 'add_product_state.dart';

@injectable
class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(
    this._productsRepository,
    this._shopProductsRepository,
  ) : super(
          const AddProductState(),
        );

  final ProductsRepository _productsRepository;

  Future<void> add(
    String productGroup,
    String productName,
    int productQuantity,
    bool isChecked,
    String productTypeName,
    int quantityGram,
  ) async {
    try {
      await _productsRepository.add(
        productGroup,
        productName,
        productQuantity,
        isChecked,
        productTypeName,
        quantityGram,
      );
      emit(const AddProductState(saved: true));
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
      emit(const AddProductState());
    } catch (error) {
      null;
    }
  }

  Future<void> updateProduct({
    required String documentID,
    required int productQuantity,
    required String productName,
    required String productTypeName,
    required int quantityGram,
  }) async {
    try {
      await _productsRepository.updateProduct(
        documentID,
        productQuantity,
        productName,
        productTypeName,
        quantityGram,
      );
      emit(const AddProductState());
    } catch (error) {
      null;
    }
  }

  Future<void> delete({required String documentID}) {
    return _productsRepository.delete(id: documentID);
  }

  StreamSubscription? _streamSubscription;

  final ShopProductsRepository _shopProductsRepository;

  Future<void> getShopProductsNamesStream(String productGroup) async {
    _streamSubscription =
        _shopProductsRepository.getShopProductsNamesStream(productGroup).listen(
      (shopProducts) {
        // final List<dynamic> shopProductsNames = shopProducts.map((element) {
        //   element.shopProductName.toLowerCase();
        //   element.productGroup.toLowerCase();
        // }).toList();
        emit(AddProductState(
          shopProducts: shopProducts,
        ));
      },
    )..onError(
            (error) {
              emit(const AddProductState(
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
