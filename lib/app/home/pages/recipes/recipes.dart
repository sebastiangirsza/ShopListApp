import 'package:ShopListApp/app/home/pages/recipes/cubit/recipes_cubit.dart';
import 'package:ShopListApp/app/home/pages/recipes/pages/add_recipes.dart';
import 'package:ShopListApp/app/home/pages/recipes/pages/recipe_details.dart';
import 'package:ShopListApp/app/models/recipes_model.dart';
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
            return ListView(
              children: [
                for (final recipesModel in recipesModels) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: InkWell(
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.black, blurRadius: 15)
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: DecorationImage(
                            opacity: 180,
                            image: NetworkImage(
                                'https://images.pexels.com/photos/1618898/pexels-photo-1618898.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(recipesModel.recipesName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                RecipeDatails(recipesModel: recipesModel),
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
