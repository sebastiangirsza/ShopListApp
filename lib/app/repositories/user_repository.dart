import 'dart:async';

import 'package:shoplistapp/app/models/user_model.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class UserRespository {
  UserRespository(this._userRemoteDataSource);
  final UserRemoteDataSource _userRemoteDataSource;

  Future<UserModel?> getUserID() async {
    final user = _userRemoteDataSource.currentUser();

    return UserModel.fromFirebase(user!);
  }
}
