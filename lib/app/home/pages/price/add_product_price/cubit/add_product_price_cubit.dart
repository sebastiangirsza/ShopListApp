import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';

part 'add_product_price_state.dart';

@injectable
class AddProductPriceCubit extends Cubit<AddProductPriceState> {
  AddProductPriceCubit(
    this._productPriceRepository,
  ) : super(const AddProductPriceState());

  final ProductPriceRepository _productPriceRepository;

  Future<void> addProductPrice(
    String productName,
    double productPrice,
    String shopName,
    String downloadURL,
    String shopDownloadURL,
  ) async {
    try {
      await _productPriceRepository.addProductPrice(
        productName,
        productPrice,
        shopName,
        downloadURL,
        shopDownloadURL,
      );
      emit(
        const AddProductPriceState(
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        AddProductPriceState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
