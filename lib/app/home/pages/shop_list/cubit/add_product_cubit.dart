import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_repository.dart';

part 'add_product_state.dart';

@injectable
class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this._productsRepository)
      : super(
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
      emit(const AddProductState());
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
}
