import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:ShopListApp/app/models/product_model.dart';
import 'package:ShopListApp/app/repositories/products_repositories.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productsRepository)
      : super(const ProductState(products: []));

  StreamSubscription? _streamSubscription;

  final ProductsRepository _productsRepository;

  Future<void> vegetables() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege =
          products.where((item) => item.productGroup == 'Warzywa').toList();
      emit(ProductState(products: vege));
    });
  }

  Future<void> meat() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege =
          products.where((item) => item.productGroup == 'Mięso').toList();
      emit(ProductState(products: vege));
    });
  }

  Future<void> bread() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege =
          products.where((item) => item.productGroup == 'Pieczywo').toList();
      emit(ProductState(products: vege));
    });
  }

  Future<void> dryProducts() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege = products
          .where((item) => item.productGroup == 'Suche produkty')
          .toList();
      emit(ProductState(products: vege));
    });
  }

  Future<void> dairy() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege =
          products.where((item) => item.productGroup == 'Nabiał').toList();
      emit(ProductState(products: vege));
    });
  }

  Future<void> householdChemicals() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege =
          products.where((item) => item.productGroup == 'Chemia').toList();
      emit(ProductState(products: vege));
    });
  }

  Future<void> other() async {
    _streamSubscription =
        _productsRepository.getProductsStream().listen((products) {
      final vege =
          products.where((item) => item.productGroup == 'Inne').toList();
      emit(ProductState(products: vege));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
