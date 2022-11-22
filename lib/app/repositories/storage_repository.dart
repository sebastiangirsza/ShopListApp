import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/data/remote_data_sources/storage_remote_data_source.dart';

@injectable
class StorageRepository {
  StorageRepository(
    this._storageRemoteDataSource,
  );
  final StorageRemoteDataSource _storageRemoteDataSource;

  Future<void> putFile(
    String userID,
    String imageName,
    File file,
  ) async {
    await _storageRemoteDataSource.putFile(
      userID: userID,
      imageName: imageName,
      file: file,
    );
  }
}
