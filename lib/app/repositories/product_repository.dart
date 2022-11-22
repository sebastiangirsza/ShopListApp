import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/product_model.dart';
import 'package:shoplistapp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class ProductsRepository {
  ProductsRepository(this._productRemoteDataSource, this._userRemoteDataSource);
  final ProductRemoteDataSource _productRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;
  Stream<List<ProductModel>> getProductsStream(String productGroup) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _productRemoteDataSource.getProductsStream().map((querySnapshots) =>
        querySnapshots.docs
            .map((products) => ProductModel.fromJson(products))
            .where((item) => item.productGroup == productGroup)
            .toList());
  }

  Stream<List<ProductModel>> getProductsQuantityStream(String productGroup) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _productRemoteDataSource.getProductsStream().map((querySnapshots) =>
        querySnapshots.docs
            .map((products) => ProductModel.fromJson(products))
            .where((item) => item.productGroup == productGroup)
            .where((element) => element.isChecked == false)
            .toList());
  }

  Future<void> add(
    String productGroup,
    String productName,
    int productQuantity,
    bool isChecked,
    String productTypeName,
    int quantityGram,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _productRemoteDataSource.add(
      productGroup,
      productName,
      productQuantity,
      isChecked,
      productTypeName,
      quantityGram,
    );
  }

  Future<void> isChecked(
    bool isChecked,
    String id,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _productRemoteDataSource.isChecked(isChecked, id);
  }

  Future<void> updateProduct(
    String documentID,
    int productQuantity,
    String productName,
    String productTypeName,
    int quantityGram,
  ) async {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    await _productRemoteDataSource.updateProduct(
      documentID,
      productQuantity,
      productName,
      productTypeName,
      quantityGram,
    );
  }

  Future<void> delete({required String id}) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _productRemoteDataSource.delete(id: id);
  }
}
