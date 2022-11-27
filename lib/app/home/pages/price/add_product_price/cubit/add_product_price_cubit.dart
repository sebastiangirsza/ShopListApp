import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';
import 'package:shoplistapp/app/repositories/storage_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/storage_remote_data_source.dart';

part 'add_product_price_state.dart';

@injectable
class AddProductPriceCubit extends Cubit<AddProductPriceState> {
  AddProductPriceCubit(
    this._productPriceRepository,
    this._userRepository,
    this._storageRepository,
    this._storageRemoteDataSource,
  ) : super(const AddProductPriceState());

  final ProductPriceRepository _productPriceRepository;
  final UserRespository _userRepository;
  final StorageRepository _storageRepository;
  final StorageRemoteDataSource _storageRemoteDataSource;

  Future<void> addProductPrice(
    String productName,
    double productPrice,
    String shopName,
    String imageName,
    String imagePath,
    String shopDownloadURL,
  ) async {
    final user = await _userRepository.getUserID();
    final userID = user!.uid;
    File file = File(imagePath);
    try {
      await _storageRepository.putFile(
        userID,
        imageName,
        file,
      );

      final downloadURL = await _storageRemoteDataSource.downloadURL(
        userID: userID,
        imageName: imageName,
      );

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
