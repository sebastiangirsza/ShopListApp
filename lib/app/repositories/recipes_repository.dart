import 'package:shoplistapp/app/models/recipes_model.dart';
import 'package:shoplistapp/data/remote_data_sources/recipes_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class RecipesRepository {
  RecipesRepository(this._recipesRemoteDataSource, this._userRemoteDataSource);
  final RecipesRemoteDataSource _recipesRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  Stream<List<RecipesModel>> getRecipesStream() {
    final userID = _userRemoteDataSource.getUserID();
    if (userID == null) {
      throw Exception('Użytkownik nie jest zalogowany');
    }
    return _recipesRemoteDataSource.getRecipesStream().map((querySnapshots) =>
        querySnapshots.docs
            .map((recipes) => RecipesModel.fromJson(recipes))
            .toList());
  }

  Future<void> add(
    String recipesName,
    String recipesProductName,
    String recipesMakeing,
    String imageName,
  ) async {
    await _recipesRemoteDataSource.add(
      recipesName,
      recipesProductName,
      recipesMakeing,
      imageName,
    );
  }
}
