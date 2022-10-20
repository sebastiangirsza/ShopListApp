import 'dart:io';

import 'package:ShopListApp/app/home/pages/recipes/pages/add_recipes/cubit/add_recipes_cubit.dart';
import 'package:ShopListApp/app/repositories/recipes_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/recipes_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';
import 'package:file_picker/file_picker.dart';
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
            actions: const [],
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
  final TextEditingController? recipesMakeing = TextEditingController();
  int quantityProducts = 1;

  final List<TextEditingController> _controller =
      List.generate(50, (i) => TextEditingController());
  String? imageName;
  var pickedImage;
  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();

    int maxLines = 10;

    return BlocProvider(
      create: (context) => AddRecipesCubit(
          RecipesRepository(RecipesRemoteDataSource(), UserRemoteDataSource())),
      child: BlocBuilder<AddRecipesCubit, AddRecipesState>(
        builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 15),
              Center(
                child: SizedBox(
                  width: 120,
                  height: 100,
                  child: InkWell(
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );

                      if (result == null) {
                        return null;
                      }

                      final path = result.files.single.path!;
                      final fileName = result.files.single.name;

                      setState(() {
                        imageName = fileName;
                      });
                      setState(() {
                        pickedImage = path;
                      });
                    },
                    child: (pickedImage == null)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(color: Colors.green, blurRadius: 15)
                                ],
                              ),
                              padding: const EdgeInsets.all(10),
                              width: 120,
                              alignment: Alignment.center,
                              child:
                                  Image.asset('images/icon/add_photo_icon.png'),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(
                                    File(pickedImage),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(color: Colors.green, blurRadius: 15)
                                ],
                              ),
                              padding: const EdgeInsets.all(10),
                              width: 120,
                              alignment: Alignment.center,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Center(child: Text('Nazwa potrawy')),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.white.withOpacity(0.5),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      hintText: 'Przykład: Wrapy z piersią z kurczaka',
                      border: InputBorder.none,
                    ),
                    onChanged: (newProduct) {
                      setState(() {
                        recipesName = newProduct;
                      });
                    }),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 15,
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      onPressed: () {
                        if (quantityProducts >= 2) {
                          setState(() {
                            quantityProducts--;
                          });
                        } else {
                          null;
                        }
                      },
                      child: const Icon(Icons.remove)),
                  const SizedBox(width: 15),
                  const Center(child: Text('Potrzebne produkty:')),
                  const SizedBox(width: 15),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          elevation: 15,
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller[i],
                        decoration: const InputDecoration(
                          hintText: 'Przykład: Pierś z kurczaka 250g',
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 15),
              const Center(child: Text('Sposób przygotowania')),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  height: maxLines * 24,
                  child: TextField(
                    controller: recipesMakeing,
                    maxLines: maxLines,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            'Przykład:\n1. Rozgrzej 10g oleju na patelni.\n2. Pokrój kurczaka na drobne kawałki.'),
                  )),
              IconButton(
                  onPressed: recipesName == null ||
                          imageName == null ||
                          recipesMakeing == null
                      ? null
                      : () {
                          context
                              .read<AddRecipesCubit>()
                              .uploadFile(pickedImage, imageName!);
                          // storage.uploadFile(pickedImage, imageName!);
                          List<String> textList = _controller
                              .getRange(0, quantityProducts)
                              .map((x) => x.text)
                              .toList();
                          context.read<AddRecipesCubit>().add(
                              recipesName!,
                              textList.join(",\n").toString(),
                              recipesMakeing!.text,
                              imageName!);
                          Navigator.of(context).pop();
                        },
                  icon: const Icon(Icons.save_alt)),
            ],
          );
        },
      ),
    );
  }
}
