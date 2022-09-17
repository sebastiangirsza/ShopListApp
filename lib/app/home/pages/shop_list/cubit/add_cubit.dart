import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:shoplistappsm/app/repositories/products_repositories.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit(this._productsRepository)
      : super(
          const AddState(),
        );

  final ProductsRepository _productsRepository;

  Future<void> add(
    String productGroup,
    String productName,
    int productQuantity,
    bool isChecked,
  ) async {
    try {
      await _productsRepository.add(
        productGroup,
        productName,
        productQuantity,
        isChecked,
      );
      emit(const AddState());
    } catch (error) {}
  }

  Future<void> delete({required String documentID}) {
    return _productsRepository.delete(id: documentID);
  }
}
