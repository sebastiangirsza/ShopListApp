import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/models/purchased_product_model.dart';
import 'package:shoplistapp/app/repositories/purchased_products_repository.dart';

part 'your_products_state.dart';

class YourProductsCubit extends Cubit<YourProductsState> {
  YourProductsCubit(this._purchasedProductsRepository)
      : super(
          const YourProductsState(),
        );

  StreamSubscription? _streamSubscription;

  final PurchasedProductsRepository _purchasedProductsRepository;

  Future<void> start() async {
    _streamSubscription = _purchasedProductsRepository
        .getPurchasedProductsStream()
        .listen((purchasedProduct) {
      emit(YourProductsState(purchasedProducts: purchasedProduct));
    });
  }

  Future<void> addYourProduct(
    String purchasedProductGroup,
    String purchasedProductName,
    DateTime purchasedProductDate,
    String storageName,
    bool isDated,
    List listaProcura,
    String productTypeName,
    int productPortion,
    bool frozen,
  ) async {
    try {
      await _purchasedProductsRepository.addYourProduct(
        purchasedProductGroup,
        purchasedProductName,
        purchasedProductDate,
        storageName,
        isDated,
        listaProcura,
        productTypeName,
        productPortion,
        frozen,
      );
      emit(const YourProductsState());
    } catch (error) {
      null;
    }
  }

  Future<void> isDated({
    required bool isDated,
    required String documentID,
    required DateTime purchasedProductDate,
  }) async {
    try {
      await _purchasedProductsRepository.isDated(
        isDated,
        documentID,
        purchasedProductDate,
      );
      emit(const YourProductsState());
    } catch (error) {
      null;
    }
  }

  Future<void> updateStorage({
    required String storageName,
    required String documentID,
    required bool frozen,
  }) async {
    try {
      await _purchasedProductsRepository.updateStorage(
        storageName,
        documentID,
        frozen,
      );
      emit(const YourProductsState());
    } catch (error) {
      null;
    }
  }

  Future<void> deletePurchasedProduct({required String documentID}) {
    return _purchasedProductsRepository.deletePurchasedProduct(id: documentID);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
