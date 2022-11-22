import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/user_model.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class FirebaseAuthRespository {
  FirebaseAuthRespository(this._userRemoteDataSource);
  final UserRemoteDataSource _userRemoteDataSource;

  Future<UserModel?> currentUser() async {
    final user = _userRemoteDataSource.currentUser();
    if (user != null) {
      return UserModel.fromFirebase(user);
    } else {
      return null;
    }
  }

  Stream<UserModel?> userModelStream() => _userRemoteDataSource
      .getInstance()
      .authStateChanges()
      .map((user) => (user != null) ? UserModel.fromFirebase(user) : null);

  Future<UserModel?> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await _userRemoteDataSource.getInstance().createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      final user = _userRemoteDataSource.currentUser();
      if (user != null) {
        return UserModel.fromFirebase(user);
      } else {
        throw Exception();
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<UserModel?> logIn({
    required String email,
    required String password,
  }) async {
    await _userRemoteDataSource.getInstance().signInWithEmailAndPassword(
          email: email,
          password: password,
        );
    final user = _userRemoteDataSource.currentUser();
    if (user != null) {
      return UserModel.fromFirebase(user);
    } else {
      throw Exception();
    }
  }

  Future<void> logOut() async {
    await _userRemoteDataSource.getInstance().signOut();
  }
}
