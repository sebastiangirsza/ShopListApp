import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/product_price_model.dart';
import 'package:shoplistapp/data/remote_data_sources/product_price_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';
// import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class ProductPriceRepository {
  ProductPriceRepository(
      this._productPriceRemoteDataSource, this._userRemoteDataSource);
  final ProductPriceRemoteDataSource _productPriceRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  Stream<List<ProductPriceModel>> getProductPriceStream(String productName) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _productPriceRemoteDataSource.getProductPriceStream().map(
        (querySnapshots) => querySnapshots.docs
            .map((productsPrice) => ProductPriceModel.fromJson(productsPrice))
            .where((element) => element.productName == productName)
            .toList());
  }

  Future<void> addProductPrice(
    String productName,
    double productPrice,
    String shopName,
    String downloadURL,
    String shopDownloadURL,
  ) async {
    await _productPriceRemoteDataSource.addProductPrice(
      productName,
      productPrice,
      shopName,
      downloadURL,
      shopDownloadURL,
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
