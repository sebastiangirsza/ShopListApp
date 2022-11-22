import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
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

  // Future<UserCredential> logIn({email, password}) {
  //   return FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  bool emailVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
  }

  Future<void> sendEmailVerification() {
    return FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }
}
