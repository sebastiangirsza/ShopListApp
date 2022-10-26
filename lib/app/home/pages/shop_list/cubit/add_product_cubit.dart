import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/repositories/products_repositories.dart';

part 'add_product_state.dart';

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
  ) async {
    try {
      await _productsRepository.add(
        productGroup,
        productName,
        productQuantity,
        isChecked,
        productTypeName,
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

  Future<void> delete({required String documentID}) {
    return _productsRepository.delete(id: documentID);
  }
}
