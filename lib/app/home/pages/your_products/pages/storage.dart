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
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
          title: Text(
              style: GoogleFonts.getFont('Saira',
                  fontWeight: FontWeight.bold, fontSize: 25),
              storageName),
        ),
        body: BlocProvider(
          create: (context) => YourProductsCubit(ProductsRepository())..start(),
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
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Container(
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black, blurRadius: 15)
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.blue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
        ));
  }
}
