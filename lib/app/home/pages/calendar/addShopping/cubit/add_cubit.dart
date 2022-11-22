import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/repositories/items_repository.dart';

part 'add_state.dart';

@injectable
class AddCubit extends Cubit<AddState> {
  AddCubit(this._itemsRpository) : super(const AddState());

  final ItemsRepository _itemsRpository;

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    try {
      await _itemsRpository.add(title, imageURL, releaseDate);
      emit(const AddState(saved: true));
    } catch (error) {
      emit(AddState(errorMessage: error.toString()));
    }
  }
}
