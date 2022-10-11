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
    DateTime purchasedProductDate,
    String storageName,
    bool isDated,
    List listaProcura,
  ) async {
    try {
      await _purchasedProductsRepository.addYourProduct(
        purchasedProductGroup,
        purchasedProductName,
        purchasedProductDate,
        storageName,
        isDated,
        listaProcura,
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

  Future<void> deletePurchasedProduct({required String documentID}) {
    return _purchasedProductsRepository.deletePurchasedProduct(id: documentID);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
