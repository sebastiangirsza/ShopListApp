import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';
import 'package:shoplistapp/app/repositories/storage_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/storage_remote_data_source.dart';

part 'add_shop_product_state.dart';

@injectable
class AddShopProductsCubit extends Cubit<AddShopProductsState> {
  AddShopProductsCubit(
    this._userRepository,
    this._storageRemoteDataSource,
    this._storageRepository,
    this._shopProductsRepository,
  ) : super(const AddShopProductsState());

  final UserRespository _userRepository;
  final StorageRemoteDataSource _storageRemoteDataSource;
  final StorageRepository _storageRepository;
  final ShopProductsRepository _shopProductsRepository;

  Future<void> addShopProduct(
    String imageName,
    String imagePath,
    String shopProductName,
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

      await _shopProductsRepository.addShopProduct(
        shopProductName,
        downloadURL,
      );
      emit(
        const AddShopProductsState(
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        AddShopProductsState(
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
