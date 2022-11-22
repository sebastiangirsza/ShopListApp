import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/models/purchased_product_model.dart';
import 'package:shoplistapp/data/remote_data_sources/recipes_product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

@injectable
class RecipesProductsRepository {
  RecipesProductsRepository(
      this._recipesProductRemoteDataSource, this._userRemoteDataSource);
  final RecipesProductRemoteDataSource _recipesProductRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  Stream<List<PurchasedProductModel>> getRecipesProductsStream(
      String searchKey) {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _recipesProductRemoteDataSource
        .getRecipesProductsStream(searchKey)
        .map((querySnapshots) => querySnapshots.docs
            .map((purchasedProducts) =>
                PurchasedProductModel.fromJson(purchasedProducts))
            // .where((item) => item.listaProcura
            //     .toString()
            //     .toLowerCase()
            //     .contains(searchKey.toLowerCase()))
            .toList());
  }
}
