import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_model.dart';
import 'package:shoplistapp/app/repositories/shop_repository.dart';

part 'shop_state.dart';

@injectable
class ShopCubit extends Cubit<ShopState> {
  ShopCubit(this._shopRepository) : super(const ShopState(shops: []));

  StreamSubscription? _streamSubscription;
  final ShopRepository _shopRepository;

  Future<void> start() async {
    _streamSubscription = _shopRepository.getShopsStream().listen(
      (shops) {
        emit(ShopState(shops: shops));
      },
    )..onError(
        (error) {
          emit(const ShopState(shops: []));
        },
      );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
