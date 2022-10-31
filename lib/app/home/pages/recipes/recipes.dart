import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/recipes/cubit/recipes_cubit.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/add_recipes/add_recipes.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/recipe_details/recipe_details.dart';
import 'package:shoplistapp/app/repositories/recipes_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/recipes_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const AddRecipesPage(),
            fullscreenDialog: true,
          ));
        },
        backgroundColor: const Color.fromARGB(255, 0, 63, 114),
        splashColor: Colors.black12,
        child: Stack(
          children: [
            const Center(
                child: Icon(
              Icons.add,
              size: 50,
              color: Color.fromARGB(255, 0, 80, 146),
            )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dodaj',
                    style: GoogleFonts.getFont('Saira',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'przepis',
                    style: GoogleFonts.getFont('Saira',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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

            return GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  for (final recipesModel in recipesModels) ...[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                    offset: Offset(3, 3),
                                  )
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                (recipesModel.downloadURL == 'www')
                                    ? Container(
                                        height: 120,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Colors.black,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 15)
                                            ],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://firebasestorage.googleapis.com/v0/b/shop-list-sm.appspot.com/o/white_screen.jpg?alt=media&token=1389efdb-c134-4229-9298-818618c29a96'),
                                                fit: BoxFit.cover)),
                                        child: Center(
                                            child: Text(
                                          'Image not found',
                                          style: GoogleFonts.getFont(
                                            'Saira',
                                            color: const Color.fromARGB(
                                                255, 0, 63, 114),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                      )
                                    : Container(
                                        height: 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            boxShadow: const <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 15)
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  recipesModel.downloadURL,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(recipesModel.recipesName,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
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
                    )
                  ],
                ]);
          },
        ),
      ),
    );
  }
}
