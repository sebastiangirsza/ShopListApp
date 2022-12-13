import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_model.dart';
import 'package:shoplistapp/data/remote_data_sources/shop_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class ShopRepository {
  ShopRepository(this._shopRemoteDataSource, this._userRemoteDataSource);
  final ShopRemoteDataSource _shopRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  Stream<List<ShopModel>> getShopsStream() {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _shopRemoteDataSource.getShopsStream().map((querySnapshots) =>
        querySnapshots.docs.map((shops) => ShopModel.fromJson(shops)).toList());
  }

  Stream<List<ShopModel>> getShopsLogoStream(String shopName) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _shopRemoteDataSource.getShopsStream().map((querySnapshots) =>
        querySnapshots.docs
            .map((shops) => ShopModel.fromJson(shops))
            .where((element) => element.shopName == shopName)
            .toList());
  }

  Future<void> addShop(
    String shopName,
    String downloadURL,
  ) async {
    await _shopRemoteDataSource.addShop(
      shopName,
      downloadURL,
    );
  }

  Future<void> addPriceToNewShop(
    String shopProductName,
    double productPrice,
    String shopDownloadURL,
    String shopName,
  ) async {
    await _shopRemoteDataSource.addPriceToNewShop(
      shopProductName,
      productPrice,
      shopDownloadURL,
      shopName,
    );
  }

  // Future<void> delete({required String id}) {
  //   final userID = _userRemoteDataSource.getUserID();
  //   if (userID == null) {
  //     throw Exception('Użytkownik nie jest zalogowany');
  //   }
  //   return _recipesRemoteDataSource.delete(id: id);
  // }
}
