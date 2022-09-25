import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ShopListApp/app/models/purchased_product_model.dart';
import 'package:ShopListApp/app/repositories/purchased_products_repository.dart';

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
    int purchasedProductQuantity,
    String storageName,
  ) async {
    try {
      await _purchasedProductsRepository.addYourProduct(
        purchasedProductGroup,
        purchasedProductName,
        purchasedProductQuantity,
        storageName,
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
