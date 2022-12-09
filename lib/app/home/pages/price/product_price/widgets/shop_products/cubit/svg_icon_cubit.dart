import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/svg_icon_model.dart';
import 'package:shoplistapp/app/repositories/svg_icon_repository.dart';

part 'svg_icon_state.dart';

@injectable
class SvgIconCubit extends Cubit<SvgIconState> {
  SvgIconCubit(this._svgIconRepository)
      : super(const SvgIconState(svgIcons: []));

  StreamSubscription? _streamSubscription;
  final SvgIconRepository _svgIconRepository;

  Future<void> start(String productGroup) async {
    _streamSubscription =
        _svgIconRepository.getSvgIconStream(productGroup).listen(
      (svgIcons) {
        emit(SvgIconState(
          svgIcons: svgIcons,
        ));
      },
    )..onError(
            (error) {
              emit(const SvgIconState(
                svgIcons: [],
              ));
            },
          );
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
