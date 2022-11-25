import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/item_model.dart';
import 'package:shoplistapp/app/repositories/product_price_repository.dart';

part 'price_state.dart';

@injectable
class PriceCubit extends Cubit<PriceState> {
  PriceCubit(this._productPriceRepository) : super(const PriceState());

  final ProductPriceRepository _productPriceRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    _streamSubscription =
        _productPriceRepository.getProductPriceStream().listen(
      (productPrice) {
        // emit(PriceState(items: productPrice.to));
      },
    )..onError(
            (error) {
              emit(const PriceState(loadingErrorOccured: true));
            },
          );
  }

  // Future<void> remove({required String documentID}) async {
  //   try {
  //     await _itemsRpository.delete(id: documentID);
  //   } catch (error) {
  //     emit(
  //       const PriceState(removingErrorOccured: true),
  //     );
  //     start();
  //   }
  // }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
