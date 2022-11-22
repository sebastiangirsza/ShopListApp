import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/purchased_product_model.dart';
import 'package:shoplistapp/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class PurchasedProductsRepository {
  PurchasedProductsRepository(
      this._purchasedProductRemoteDataSource, this._userRemoteDataSource);
  final PurchasedProductsRemoteDataSource _purchasedProductRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  Stream<List<PurchasedProductModel>> getPurchasedProductsStream() {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _purchasedProductRemoteDataSource
        .getPurchasedProductsStream()
        .map((querySnapshots) {
      return querySnapshots.docs.map((purchasedProducts) {
        return PurchasedProductModel.fromJson(purchasedProducts);
      }).toList();
    });
  }

  Future<void> addYourProduct(
    String purchasedProductGroup,
    String purchasedProductName,
    DateTime purchasedProductDate,
    String storageName,
    bool isDated,
    List listaProcura,
    String productTypeName,
    int productPortion,
    bool frozen,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _purchasedProductRemoteDataSource.addYourProduct(
      purchasedProductGroup,
      purchasedProductName,
      purchasedProductDate,
      storageName,
      isDated,
      listaProcura,
      productTypeName,
      productPortion,
      frozen,
    );
  }

  Future<void> isDated(
    bool isDated,
    String id,
    DateTime purchasedProductDate,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _purchasedProductRemoteDataSource.isDated(
      isDated,
      id,
      purchasedProductDate,
    );
  }

  Future<void> updateStorage(
    String storageName,
    String id,
    bool frozen,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _purchasedProductRemoteDataSource.updateStorage(
      storageName,
      id,
      frozen,
    );
  }

  Future<void> updatePortion(
    int productPortion,
    String documentID,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _purchasedProductRemoteDataSource.updatePortion(
      productPortion,
      documentID,
    );
  }

  Future<void> deletePurchasedProduct({required String id}) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _purchasedProductRemoteDataSource.deletePurchasedProduct(id: id);
  }
}
