import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/core/enums.dart';
import 'package:shoplistapp/app/home/pages/recipes/cubit/recipes_cubit.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/add_recipes/add_recipes.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/recipe_details/recipe_details.dart';
import 'package:shoplistapp/app/models/recipes_model.dart';
import 'package:shoplistapp/app/repositories/recipes_repository.dart';
import 'package:shoplistapp/app/repositories/user_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/recipes_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/storage_remote_data_source.dart';
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
            UserRespository(UserRemoteDataSource()),
            StorageRemoteDataSource())
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
                return RecipesGridView(recipesModels: recipesModels);

              case Status.error:
                return const Text('error');
            }
          },
        ),
      ),
    );
  }
}

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({
    Key? key,
    required this.recipesModels,
  }) : super(key: key);

  final List<RecipesModel> recipesModels;

  @override
  Widget build(BuildContext context) {
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
                                        color: Colors.black, blurRadius: 15)
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(35.0),
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
                                          color: Colors.black, blurRadius: 15)
                                    ],
                                    borderRadius: const BorderRadius.all(
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
                    DeleteRecipesWidget(recipesModel: recipesModel)
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RecipeDatails(recipesModel: recipesModel),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            )
          ],
        ]);
  }
}

class DeleteRecipesWidget extends StatelessWidget {
  const DeleteRecipesWidget({
    Key? key,
    required this.recipesModel,
  }) : super(key: key);

  final RecipesModel recipesModel;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))),
          child: IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return BlocProvider(
                      create: (context) => RecipesCubit(
                          RecipesRepository(RecipesRemoteDataSource(),
                              UserRemoteDataSource()),
                          UserRespository(UserRemoteDataSource()),
                          StorageRemoteDataSource())
                        ..recipes(),
                      child: BlocBuilder<RecipesCubit, RecipesState>(
                        builder: (context, state) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              backgroundColor:
                                  const Color.fromARGB(255, 200, 233, 255),
                              title: Text(
                                style: GoogleFonts.getFont('Saira',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                'Czy na pewno chcesz usunąć przepis?',
                                textAlign: TextAlign.center,
                              ),
                              content: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: double.infinity,
                                  ),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Nie',
                                                  style: GoogleFonts.getFont(
                                                      'Saira',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.black),
                                                onPressed: () {
                                                  context
                                                      .read<RecipesCubit>()
                                                      .delete(
                                                          documentID:
                                                              recipesModel.id);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Tak',
                                                  style: GoogleFonts.getFont(
                                                      'Saira',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            );
                          });
                        },
                      ),
                    );
                  }),
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
                size: 20,
              )),
        ));
  }
}
