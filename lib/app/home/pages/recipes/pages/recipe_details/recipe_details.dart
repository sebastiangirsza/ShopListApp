import 'package:ShopListApp/app/models/recipes_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDatails extends StatelessWidget {
  const RecipeDatails({
    Key? key,
    required this.recipesModel,
  }) : super(key: key);

  final RecipesModel recipesModel;

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
            recipesModel.recipesName,
            style: GoogleFonts.getFont('Saira', fontWeight: FontWeight.bold),
          ),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            fillColor: Colors.black.withOpacity(0.3),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                            hintText: 'Wyszukaj potrzebne produkty',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.white, blurRadius: 15)
                            ],
                          ),
                          child: Image.asset(
                            'images/icon/list_search_icon.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text('Potrzebne składniki:'),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white.withOpacity(0.5),
                child: Text(recipesModel.recipesProductName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              const Text('Sposób przygotowania:'),
              Container(
                color: Colors.white.withOpacity(0.5),
                child: Text(recipesModel.recipesMakeing,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
