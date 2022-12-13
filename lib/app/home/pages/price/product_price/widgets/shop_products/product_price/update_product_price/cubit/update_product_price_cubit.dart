import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';

part 'update_product_price_state.dart';

@injectable
class UpdateProductPriceCubit extends Cubit<UpdateProductPriceState> {
  UpdateProductPriceCubit(
    this._productPriceRepository,
  ) : super(const UpdateProductPriceState());

  final ProductPriceRepository _productPriceRepository;
  StreamSubscription? _streamSubscription;

  Future<void> updateProductPrice(
    double productPrice,
    String id,
  ) async {
    try {
      await _productPriceRepository.updateProductPrice(
        productPrice,
        id,
      );
      emit(
        const UpdateProductPriceState(
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        UpdateProductPriceState(
          errorMessage: error.toString(),
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
