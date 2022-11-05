import 'package:shoplistapp/app/models/item_model.dart';
import 'package:shoplistapp/data/remote_data_sources/items_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class ItemsRepository {
  ItemsRepository(this._itemsRemoteDataSource, this._userRemoteDataSource);
  final ItemsRemoteDataSource _itemsRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;
  Stream<List<ItemModel>> getItemStream() {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _itemsRemoteDataSource.getItemStream().map((querySnapshot) {
      return querySnapshot.docs.map((json) {
        return ItemModel.fromJson(json);
      }).toList();
    });
  }

  Future<void> delete({required String id}) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _itemsRemoteDataSource.delete(id: id);
  }

  Future<ItemModel> get({required String id}) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    final json = await _itemsRemoteDataSource.get(id: id);
    return ItemModel.fromJson(json);
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _itemsRemoteDataSource.add(title, imageURL, releaseDate);
  }
}
