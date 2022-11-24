import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';
import 'package:shoplistapp/app/repositories/storage_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';

part 'add_shop_state.dart';

@injectable
class AddShopCubit extends Cubit<AddShopState> {
  AddShopCubit(
      this._shopRepository, this._userRepository, this._storageRepository)
      : super(const AddShopState());

  final ShopRepository _shopRepository;
  final UserRespository _userRepository;
  final StorageRepository _storageRepository;

  // Future<void> add(
  //   String title,
  //   String imageURL,
  //   DateTime releaseDate,
  // ) async {
  //   try {
  //     await _itemsRpository.add(title, imageURL, releaseDate);
  //     emit(const AddShopState(saved: true));
  //   } catch (error) {
  //     emit(AddShopState(errorMessage: error.toString()));
  //   }
  // }

  Future<void> addShop(
    String shopName,
    String imageName,
    String imagePath,
    String downloadURL,
  ) async {
    final user = await _userRepository.getUserID();
    final userID = user!.uid;
    File file = File(imagePath);
    try {
      await _storageRepository.putFile(userID, imageName, file);
      await _shopRepository.addShop(
        shopName,
        downloadURL,
      );

      emit(const AddShopState(saved: true));
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
