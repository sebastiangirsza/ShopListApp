import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/core/enums.dart';
import 'package:shoplistapp/app/home/pages/recipes/cubit/recipes_cubit.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/add_recipes/add_recipes.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/recipe_details/recipe_details.dart';
import 'package:shoplistapp/app/repositories/recipes_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';
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
        create: (context) => RecipesCubit(
            RecipesRepository(
                RecipesRemoteDataSource(), UserRemoteDataSource()),
            UserRespository(UserRemoteDataSource()))
          ..recipes(),
        child: BlocBuilder<RecipesCubit, RecipesState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const Center(
                  child: Text('Initial state'),
                );
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.success:
                final recipesModels = state.recipes;
                return GridView.count(
                    padding: const EdgeInsets.only(bottom: 75),
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
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(35.0),
                                              child: SvgPicture.asset(
                                                'images/icon/image_not_found_icon.svg',
                                                color: Colors.grey,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
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

              case Status.error:
                return const Text('error');
            }
          },
        ),
      ),
    );
  }
}
