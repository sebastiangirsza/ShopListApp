import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/models/user_model.dart';
import 'package:shoplistapp/app/repositories/firebase_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseAuthRespository)
      : super(
          const AuthState(
            user: null,
          ),
        );

  StreamSubscription? _streamSubscription;

  final FirebaseAuthRespository _firebaseAuthRespository;

  Future<void> start() async {
    emit(
      const AuthState(
        user: null,
      ),
    );
    _streamSubscription = _firebaseAuthRespository.userModelStream().listen(
      (user) {
        if (user != null) {
          emit(
            AuthState(
              user: user,
            ),
          );
        } else {
          emit(
            const AuthState(
              user: null,
            ),
          );
        }
      },
    )..onError((error) {
        emit(
          const AuthState(
            user: null,
          ),
        );
      });
  }

  Future<void> createUser({
    required final String email,
    required final String password,
  }) async {
    _firebaseAuthRespository.createUser(
      email: email,
      password: password,
    );
  }

  Future<void> logIn({
    required final String email,
    required final String password,
  }) async {
    _firebaseAuthRespository.logIn(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    _firebaseAuthRespository.logOut();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
