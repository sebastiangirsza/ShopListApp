import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/add_recipes/cubit/add_recipes_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

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
            Color.fromARGB(255, 200, 233, 255),
            Color.fromARGB(255, 213, 238, 255),
            Color.fromARGB(255, 228, 244, 255),
            Color.fromARGB(255, 244, 250, 255),
          ],
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Color.fromARGB(255, 200, 233, 255),
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 7.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            elevation: 10,
            scrolledUnderElevation: 10,
            toolbarHeight: 60,
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            title: Text(
              'Dodaj przepis',
              style: GoogleFonts.getFont(
                'Saira',
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 200, 233, 255),
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 7.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ),
            ),
            actions: const [],
          ),
          body: const AddRecipesWidget()),
    );
  }
}

@injectable
class AddRecipesWidget extends StatefulWidget {
  const AddRecipesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddRecipesWidget> createState() => _AddRecipesWidgetState();
}

class _AddRecipesWidgetState extends State<AddRecipesWidget> {
  String? recipesName;
  final TextEditingController? recipesMakeing = TextEditingController();
  int quantityProducts = 1;

  final List<TextEditingController> _controller =
      List.generate(50, (i) => TextEditingController());
  final downloadURL = 'www';
  String? imageName;
  String? pickedImage;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddRecipesCubit>(),
      child: BlocListener<AddRecipesCubit, AddRecipesState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
        },
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
                          return;
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
                                    BoxShadow(
                                        color: Color.fromARGB(255, 0, 63, 114),
                                        blurRadius: 15)
                                  ],
                                ),
                                padding: const EdgeInsets.all(10),
                                width: 120,
                                alignment: Alignment.center,
                                child: Image.asset(
                                    'images/icon/add_photo_icon.png'),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(pickedImage!),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.white, blurRadius: 15)
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
                Center(
                    child: Text(
                  'Nazwa potrawy',
                  style: GoogleFonts.getFont(
                    'Saira',
                    color: const Color.fromARGB(255, 0, 63, 114),
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: TextField(
                      style: GoogleFonts.getFont('Saira',
                          fontSize: 12, color: Colors.black),
                      maxLength: 50,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.getFont('Saira',
                            fontSize: 12, color: Colors.black),
                        hintText: 'Przykład: Wrapy z piersią z kurczaka',
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
                            backgroundColor:
                                const Color.fromARGB(255, 0, 63, 114),
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
                    Center(
                        child: Text(
                      'Potrzebne produkty:',
                      style: GoogleFonts.getFont(
                        'Saira',
                        color: const Color.fromARGB(255, 0, 63, 114),
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(width: 15),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 15,
                            backgroundColor:
                                const Color.fromARGB(255, 0, 63, 114),
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
                          minLines: 1,
                          maxLines: 100,
                          style: GoogleFonts.getFont('Saira',
                              fontSize: 12, color: Colors.black),
                          controller: _controller[i],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.getFont('Saira',
                                fontSize: 12, color: Colors.black),
                            hintText: 'Przykład: Pierś z kurczaka 250g',
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 15),
                Center(
                    child: Text(
                  'Sposób przygotowania',
                  style: GoogleFonts.getFont(
                    'Saira',
                    color: const Color.fromARGB(255, 0, 63, 114),
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white.withOpacity(0.5),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    // height: maxLines * 24,
                    child: TextField(
                      style: GoogleFonts.getFont('Saira',
                          fontSize: 12, color: Colors.black),
                      controller: recipesMakeing,
                      minLines: 1,
                      maxLines: 100,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.getFont('Saira',
                              fontSize: 12, color: Colors.black),
                          hintText:
                              'Przykład:\n1. Rozgrzej 10g oleju na patelni.\n2. Pokrój kurczaka na drobne kawałki.'),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 63, 114),
                    ),
                    onPressed: recipesName == null ||
                            imageName == null ||
                            recipesMakeing == null
                        ? null
                        : () {
                            List<String> textList = _controller
                                .getRange(0, quantityProducts)
                                .map((x) => x.text)
                                .toList();
                            // context
                            //     .read<AddRecipesCubit>()
                            //     .uploadFile(pickedImage!, imageName!);

                            context.read<AddRecipesCubit>().addRecipe(
                                recipesName!,
                                textList.join(",\n").toString(),
                                recipesMakeing!.text,
                                imageName!,
                                downloadURL,
                                pickedImage!,
                                imageName!);
                          },
                    child: const Text(
                      'Dodaj przepis',
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
