import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';
import 'package:shoplistapp/app/repositories/shop_products_repository.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';
import 'package:shoplistapp/app/repositories/storage_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/storage_remote_data_source.dart';

part 'add_shop_state.dart';

@injectable
class AddShopCubit extends Cubit<AddShopState> {
  AddShopCubit(
    this._userRepository,
    this._storageRemoteDataSource,
    this._storageRepository,
    this._shopRepository,
    this._shopProductsRepository,
  ) : super(const AddShopState(shopProducts: []));

  final UserRepository _userRepository;
  final StorageRemoteDataSource _storageRemoteDataSource;
  final StorageRepository _storageRepository;
  final ShopRepository _shopRepository;
  StreamSubscription? _streamSubscription;
  final ShopProductsRepository _shopProductsRepository;

  Future<void> getShopProducts() async {
    _streamSubscription =
        _shopProductsRepository.getShopProductsStream().listen(
      (shopProducts) {
        emit(AddShopState(
          shopProducts: shopProducts,
        ));
      },
    )..onError(
            (error) {
              emit(const AddShopState(
                shopProducts: [],
              ));
            },
          );
  }

  Future<void> addShop(
    String imageName,
    String imagePath,
    String shopName,
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

      await _shopRepository.addShop(
        shopName,
        downloadURL,
      );

      emit(
        const AddShopState(
          shopProducts: [],
          saved: true,
        ),
      );
    } catch (error) {
      emit(
        AddShopState(
          errorMessage: error.toString(),
          shopProducts: const [],
        ),
      );
    }
  }

  Future<void> addPriceToNewShop(
    String imageName,
    String shopProductName,
  ) async {
    final user = await _userRepository.getUserID();
    final userID = user!.uid;

    try {
      final downloadURL = await _storageRemoteDataSource.downloadURL(
        userID: userID,
        imageName: imageName,
      );

      await _shopRepository.addPriceToNewShop(
        shopProductName,
        999999999999999,
        downloadURL,
      );
    } catch (error) {
      emit(
        AddShopState(
          errorMessage: error.toString(),
          shopProducts: const [],
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
