import 'package:firebase_auth/firebase_auth.dart';

class UserRemoteDataSource {
  String? getUserID({userID}) {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  FirebaseAuth getInstance() {
    return FirebaseAuth.instance;
  }
}
