import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';
import 'package:shoplistapp/data/remote_data_sources/shop_products_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class ShopProductsRepository {
  ShopProductsRepository(
      this._shopProductsRemoteDataSource, this._userRemoteDataSource);
  final ShopProductsRemoteDataSource _shopProductsRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  Stream<List<ShopProductsModel>> getShopProductsStream() {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _shopProductsRemoteDataSource.getShopProductsStream().map(
        (querySnapshots) => querySnapshots.docs
            .map((shopProducts) => ShopProductsModel.fromJson(shopProducts))
            .toList());
  }

  Future<void> addShopProduct(
    String shopProductName,
    String productGroup,
    String svgIcon,
  ) async {
    await _shopProductsRemoteDataSource.addShopProduct(
      shopProductName,
      productGroup,
      svgIcon,
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
