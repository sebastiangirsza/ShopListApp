import 'package:firebase_storage/firebase_storage.dart';

class StorageRemoteDataSource {
  Future<String> downloadURL({userID, imageName}) {
    return FirebaseStorage.instance
        .ref('$userID/recipes/$imageName')
        .getDownloadURL();
  }
}
