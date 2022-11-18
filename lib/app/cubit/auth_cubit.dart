import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/models/user_model.dart';
import 'package:shoplistapp/app/repositories/firebase_auth_repository.dart';

import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._firebaseAuthRespository,
    this._userRemoteDataSource,
  ) : super(
          const AuthState(
            user: null,
            errorMessages: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  final FirebaseAuthRespository _firebaseAuthRespository;
  final UserRemoteDataSource _userRemoteDataSource;

  Future<void> start() async {
    emit(
      const AuthState(
        user: null,
        errorMessages: '',
      ),
    );
    _streamSubscription = _firebaseAuthRespository.userModelStream().listen(
      (user) {
        if (user != null) {
          emit(
            AuthState(
              user: user,
              errorMessages: '',
            ),
          );
        } else {
          emit(
            const AuthState(
              user: null,
              errorMessages: '',
            ),
          );
        }
      },
    )..onError((error) {
        emit(
          const AuthState(
            user: null,
            errorMessages: '',
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
    try {
      _firebaseAuthRespository.logIn(
        email: email,
        password: password,
      );
    } catch (e) {
      emit(
        AuthState(
          user: null,
          errorMessages: e.toString(),
        ),
      );
    }
  }

  Future<void> logOut() async {
    _firebaseAuthRespository.logOut();
  }

  Future<void> checkEmailVerified(isEmailVerified) async {
    await _userRemoteDataSource.currentUser()!.reload();

    isEmailVerified = _userRemoteDataSource.emailVerified();
  }

  bool isEmailVerified() {
    return _userRemoteDataSource.emailVerified();
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit(this._userRemoteDataSource)
      : super(
          const VerificationState(
            errorMessage: null,
            sent: false,
          ),
        );
  final UserRemoteDataSource _userRemoteDataSource;

  Future<void> sendVerificationEmail() async {
    try {
      await _userRemoteDataSource.currentUser()!.sendEmailVerification();
      emit(
        const VerificationState(
          errorMessage: null,
          sent: false,
        ),
      );
    } catch (error) {
      emit(
        VerificationState(
          errorMessage: error.toString(),
          sent: true,
        ),
      );
    }
  }
}
