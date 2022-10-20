import 'package:ShopListApp/app/home/pages/recipes/cubit/recipes_cubit.dart';
import 'package:ShopListApp/app/home/pages/recipes/pages/add_recipes/add_recipes.dart';
import 'package:ShopListApp/app/home/pages/recipes/pages/recipe_details/recipe_details.dart';
import 'package:ShopListApp/app/repositories/recipes_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/recipes_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const AddRecipesPage(),
            fullscreenDialog: true,
          ));
        },
        backgroundColor: Colors.grey,
        splashColor: Colors.black12,
        child: Stack(
          children: [
            const Center(
                child: Icon(
              Icons.add,
              size: 50,
              color: Colors.black12,
            )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dodaj',
                    style: GoogleFonts.getFont('Saira',
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'przepis',
                    style: GoogleFonts.getFont('Saira',
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => RecipesCubit(RecipesRepository(
            RecipesRemoteDataSource(), UserRemoteDataSource()))
          ..recipes(),
        child: BlocBuilder<RecipesCubit, RecipesState>(
          builder: (context, state) {
            final recipesModels = state.recipes;
            return ListView(shrinkWrap: true, children: [
              for (final recipesModel in recipesModels) ...[
                BlocProvider(
                  create: (context) =>
                      RecipesImagesCubit()..downloadURL(recipesModel.imageName),
                  child: BlocBuilder<RecipesImagesCubit, RecipesImagesState>(
                    builder: (context, state) {
                      final downloadURL = state.downloadURL;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: InkWell(
                          child: Stack(
                            children: [
                              Container(
                                height: 185,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Colors.white,
                                        blurRadius: 3),
                                    BoxShadow(
                                        offset: Offset(-2, -2),
                                        color: Colors.black,
                                        blurRadius: 3),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.black, blurRadius: 15)
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          opacity: 100,
                                          image: NetworkImage(
                                            downloadURL,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 65,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25.0, bottom: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(recipesModel.recipesName,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecipeDatails(recipesModel: recipesModel),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ]);
          },
        ),
      ),
    );
  }
}
