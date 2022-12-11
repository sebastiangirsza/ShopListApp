import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/user_model.dart';
import 'package:shoplistapp/app/repositories/firebase_auth_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

part 'auth_state.dart';

@injectable
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

  Future<void> reload() async {
    await _userRemoteDataSource.currentUser()!.reload();
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
