import 'package:ShopListApp/data/remote_data_sources/recipes_remote_data_source.dart';

class RecipesRepository {
  RecipesRepository(this._recipesRemoteDataSource);
  final RecipesRemoteDataSource _recipesRemoteDataSource;

  Future<void> add(
    String recipesName,
    String recipesProductName,
    String recipesMakeing,
  ) async {
    await _recipesRemoteDataSource.add(
      recipesName,
      recipesProductName,
      recipesMakeing,
    );
  }
}
