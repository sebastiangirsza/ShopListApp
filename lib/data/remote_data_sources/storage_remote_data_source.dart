import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class StorageRemoteDataSource {
  Future<String> downloadURL({userID, imageName}) {
    return FirebaseStorage.instance
        .ref('$userID/recipes/$imageName')
        .getDownloadURL();
  }

  UploadTask putFile({userID, imageName, file}) {
    return FirebaseStorage.instance
        .ref('$userID/recipes/$imageName')
        .putFile(file);
  }
}
