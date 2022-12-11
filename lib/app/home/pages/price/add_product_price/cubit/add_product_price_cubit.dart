import 'dart:async';
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
  StreamSubscription? _streamSubscription;

  Future<void> addFirstProductPrice(
      String shopProductName, String shopDownloadURL) async {
    await _productPriceRepository.addFirstProductPrice(
      shopProductName,
      999999999999999,
      shopDownloadURL,
    );
  }

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

  // Future<void> addFirstProductPrice(
  //   String productName,
  // ) async {
  //   try {
  //     _streamSubscription = _shopRepository.getShopsStream().listen(
  //       (shops) {
  //         for (final shop in shops) {
  //           _productPriceRepository.addFirstProductPrice(
  //             productName,
  //             0,
  //             shop.shopName,
  //             // DateTime.now(),
  //           );
  //           emit(
  //             const AddProductPriceState(
  //               saved: true,
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (error) {
  //     emit(
  //       AddProductPriceState(
  //         errorMessage: error.toString(),
  //       ),
  //     );
  //   }
  // }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
