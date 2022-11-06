import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/recipes/pages/recipe_details/cubit/recipe_details_cubit.dart';
import 'package:shoplistapp/app/models/recipes_model.dart';
import 'package:shoplistapp/app/repositories/recipes_products_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/recipes_product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class RecipeDatails extends StatefulWidget {
  const RecipeDatails({
    Key? key,
    required this.recipesModel,
  }) : super(key: key);

  final RecipesModel recipesModel;

  @override
  State<RecipeDatails> createState() => _RecipeDatailsState();
}

class _RecipeDatailsState extends State<RecipeDatails> {
  String searchKey = '';
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
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          title: Text(
            widget.recipesModel.recipesName,
            style: GoogleFonts.getFont('Saira', fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              recipesDetailTitle('Potrzebne składniki'),
              recipesDetailContent(widget.recipesModel.recipesProductName, 18),
              recipesDetailTitle('Sposób przygotowania'),
              recipesDetailContent(widget.recipesModel.recipesMakeing, 15),
              searchingWidget(),
              if (searchKey != '') _SearchResults(searchKey: searchKey),
              const SizedBox(height: 15)
            ],
          ),
        ),
      ),
    );
  }

  Widget recipesDetailTitle(String title) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Color.fromARGB(255, 0, 63, 114),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 2,
            offset: Offset(3, 3),
          )
        ],
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Center(
        child: Text(title,
            style: GoogleFonts.getFont('Saira',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget recipesDetailContent(String content, double fontSize) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black,
            blurRadius: 2,
            offset: Offset(3, 3),
          )
        ],
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Text(content,
          style: GoogleFonts.getFont('Saira',
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget searchingWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.arrow_circle_down_outlined,
            color: Color.fromARGB(255, 0, 63, 114),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Sprawdź czy posiadasz potrzebne składniki:',
                    style: GoogleFonts.getFont('Saira',
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 90,
                  child: TextField(
                    maxLength: 1,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        counterText: '',
                        fillColor: Colors.black.withOpacity(0.3),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: 'Wyszukaj potrzebne produkty',
                        hintStyle: GoogleFonts.getFont('Saira',
                            color: Colors.grey, fontSize: 12),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(15),
                          width: 18,
                          child: Icon(
                            Icons.search,
                            color: const Color.fromARGB(255, 0, 63, 114)
                                .withOpacity(0.5),
                          ),
                        )),
                    onChanged: (value) {
                      setState(() {
                        searchKey = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    Key? key,
    required this.searchKey,
  }) : super(key: key);

  final String searchKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeDetailsCubit(RecipesProductsRepository(
          RecipesProductRemoteDataSource(), UserRemoteDataSource()))
        ..start(searchKey: searchKey),
      child: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
        builder: (context, state) {
          final purchasedProducts = state.purchasedProducts;
          return ListView(
            shrinkWrap: true,
            children: [
              for (final purchasedProduct in purchasedProducts) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(3, 3),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              purchasedProduct.purchasedProductName,
                              style: GoogleFonts.getFont('Saira',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              purchasedProduct.storageName,
                              style: GoogleFonts.getFont('Saira',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ],
          );
        },
      ),
    );
  }
}
