import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistappsm/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:shoplistappsm/app/repositories/products_repositories.dart';

class StoragePage extends StatelessWidget {
  const StoragePage({
    required this.storageName,
    Key? key,
  }) : super(key: key);
  final String storageName;
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
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              title: Text(
                  style: GoogleFonts.getFont('Saira',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                  storageName),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))),
          body: BlocProvider(
            create: (context) =>
                YourProductsCubit(ProductsRepository())..start(),
            child: BlocBuilder<YourProductsCubit, YourProductsState>(
              builder: (context, state) {
                final purchasedProductModels = state.purchasedProducts;
                return SizedBox(
                  child: ListView(
                    children: [
                      for (final purchasedProductsModel
                          in purchasedProductModels) ...[
                        if (purchasedProductsModel.storageName ==
                            storageName) ...[
                          Dismissible(
                            key: UniqueKey(),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                context
                                    .read<YourProductsCubit>()
                                    .deletePurchasedProduct(
                                        documentID: purchasedProductsModel.id);
                              } else {}
                            },
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 0, 63, 114),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black, blurRadius: 5)
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            style: GoogleFonts.getFont('Saira'),
                                            purchasedProductsModel
                                                .purchasedProductName),
                                        Text(
                                            style: GoogleFonts.getFont('Saira'),
                                            purchasedProductsModel
                                                .purchasedProductQuantity
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ]
                      ]
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
