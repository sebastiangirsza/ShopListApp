import 'package:ShopListApp/app/home/pages/recipes/cubit/recipes_cubit.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:ShopListApp/app/repositories/recipes_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/recipes_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRecipesPage extends StatelessWidget {
  const AddRecipesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 40, 40, 40),
            Color.fromARGB(255, 60, 60, 60),
            Color.fromARGB(255, 80, 80, 80),
            Color.fromARGB(255, 100, 100, 100),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: Text(
              'Dodaj przepis',
              style: GoogleFonts.getFont('Saira', fontWeight: FontWeight.bold),
            ),
            actions: [],
          ),
          body: const _AddRecipesWidget()),
    );
  }
}

class _AddRecipesWidget extends StatefulWidget {
  const _AddRecipesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_AddRecipesWidget> createState() => _AddRecipesWidgetState();
}

class _AddRecipesWidgetState extends State<_AddRecipesWidget> {
  String? recipesName;
  String? recipesProductName;
  String? recipesMakeing;
  int quantityProducts = 2;

  @override
  Widget build(BuildContext context) {
    int maxLines = 10;

    return BlocProvider(
      create: (context) =>
          AddRecipesCubit(RecipesRepository(RecipesRemoteDataSource())),
      child: BlocBuilder<AddRecipesCubit, AddRecipesState>(
        builder: (context, state) {
          return ListView(
            children: [
              const SizedBox(height: 15),
              const Center(child: Text('Nazwa potrawy')),
              TextField(onChanged: (newProduct) {
                setState(() {
                  recipesName = newProduct;
                });
              }),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quantityProducts--;
                        });
                      },
                      child: const Icon(Icons.remove)),
                  const SizedBox(width: 15),
                  const Center(child: Text('Potrzebne produkty:')),
                  const SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          quantityProducts++;
                        });
                      },
                      child: const Icon(Icons.add)),
                ],
              ),
              for (var i = 0; i < quantityProducts; i++)
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(filled: true),
                        onChanged: (newProduct) {
                          setState(() {
                            recipesProductName = newProduct;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 15),
              const Center(child: Text('Sposób przygotowania')),
              Container(
                  margin: const EdgeInsets.all(12),
                  height: maxLines * 24,
                  child: TextField(
                    onChanged: (newProduct) {
                      setState(() {
                        recipesMakeing = newProduct;
                      });
                    },
                    maxLines: maxLines,
                    decoration: const InputDecoration(
                      filled: true,
                    ),
                  )),
              IconButton(
                  onPressed: () {
                    context.read<AddRecipesCubit>().add(
                        recipesName!, recipesProductName!, recipesMakeing!);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.save_alt))
            ],
          );
        },
      ),
    );
  }
}
