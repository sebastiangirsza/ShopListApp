import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:shoplistappsm/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:shoplistappsm/app/models/product_model.dart';
import 'package:shoplistappsm/app/repositories/products_repositories.dart';
import 'package:shoplistappsm/app/repositories/purchased_products_repository.dart';
import 'package:shoplistappsm/data/remote_data_sources/product_remote_data_source.dart';
import 'package:shoplistappsm/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:shoplistappsm/data/remote_data_sources/user_remote_data_source.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({
    required this.categoriesName,
    super.key,
  });
  final String categoriesName;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ProductsRepository(
          ProductRemoteDataSource(), UserRemoteDataSource())),
      child: BlocBuilder<AddCubit, AddState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProductCubit(ProductsRepository(
                ProductRemoteDataSource(), UserRemoteDataSource()))
              ..start(),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final productModels = state.products;
                return ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        for (final productModel in productModels) ...[
                          if (productModel.productGroup ==
                              widget.categoriesName) ...[
                            const SizedBox(height: 5),
                            _Dismissible(productModel: productModel),
                            const SizedBox(height: 5)
                          ],
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _Dismissible extends StatefulWidget {
  const _Dismissible({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<_Dismissible> createState() => _DismissibleState();
}

class _DismissibleState extends State<_Dismissible> {
  var isChecked = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(PurchasedProductsRepository(
          PurchasedProductsRemoteDataSource(), UserRemoteDataSource())),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          return Dismissible(
            key: UniqueKey(),
            background: BlocProvider(
              create: (context) => AddCubit(ProductsRepository(
                  ProductRemoteDataSource(), UserRemoteDataSource())),
              child: BlocBuilder<AddCubit, AddState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: (widget.productModel.isChecked == false)
                        ? const DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.green,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 32.0),
                                child: Icon(
                                  Icons.done,
                                ),
                              ),
                            ),
                          )
                        : const DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 32.0),
                                child: Icon(
                                  Icons.remove_done,
                                ),
                              ),
                            ),
                          ),
                  );
                },
              ),
            ),
            secondaryBackground: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.red,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 32.0),
                    child: Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ),
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                context
                    .read<AddCubit>()
                    .delete(documentID: widget.productModel.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            style: GoogleFonts.getFont('Saira',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            'Produkt usunięty z listy zakupów'),
                      ],
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                context.read<AddCubit>().isChecked(
                    isChecked: isChecked, documentID: widget.productModel.id);
                setState(() {
                  isChecked = !isChecked;
                });
                (isChecked == false)
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 600),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  'Produkt dodany do listy kupionych'),
                            ],
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      )
                    : ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 600),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  'Produkt usunięty z listy kupionych'),
                            ],
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      );
                ;
              }
            },
            child: _ProductsList(productModel: widget.productModel),
          );
        },
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: (productModel.isChecked == false)
            ? const BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black, blurRadius: 5)
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)))
            : const BoxDecoration(
                color: Colors.green,
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black, blurRadius: 5)
                ],
                borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productModel.productName,
                style: GoogleFonts.getFont('Saira', fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    productModel.productQuantity.toString(),
                    style: GoogleFonts.getFont('Saira', fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      (productModel.isChecked == true)
                          ? showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return _AlertDialog(productModel: productModel);
                              })
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 600),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        style: GoogleFonts.getFont('Saira',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        'Produkt nie został kupiony'),
                                  ],
                                ),
                                backgroundColor: Colors.blue,
                              ),
                            );
                      ;
                    },
                    child: const Icon(
                        size: 17,
                        color: Colors.white,
                        Icons.shopping_bag_outlined),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(PurchasedProductsRepository(
          PurchasedProductsRemoteDataSource(), UserRemoteDataSource()))
        ..start(),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          String? storageName;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                title: Text(
                  style:
                      GoogleFonts.getFont('Saira', fontWeight: FontWeight.bold),
                  'Wybierz miejsce przechowywania',
                  textAlign: TextAlign.center,
                ),
                content: DropdownButtonFormField(
                  decoration: InputDecoration(
                      label: Text(
                          style: GoogleFonts.getFont('Saira'),
                          'Miejsce przechowywania')),
                  isExpanded: true,
                  value: storageName,
                  onChanged: (newProduct) {
                    setState(() {
                      storageName = newProduct!;
                    });
                  },
                  items: <String>[
                    'Lodówka',
                    'Zamrażarka',
                    'Szafka kuchenna',
                    'Chemia',
                    'Inne',
                  ].map<DropdownMenuItem<String>>(
                    (storageName) {
                      return DropdownMenuItem<String>(
                        value: storageName,
                        child: Text(
                          style: GoogleFonts.getFont('Saira'),
                          storageName,
                        ),
                      );
                    },
                  ).toList(),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cofnij',
                        style:
                            GoogleFonts.getFont('Saira', color: Colors.black),
                      )),
                  BlocProvider(
                    create: (context) => AddCubit(ProductsRepository(
                        ProductRemoteDataSource(), UserRemoteDataSource())),
                    child: BlocBuilder<AddCubit, AddState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 600),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        style: GoogleFonts.getFont('Saira',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        'Produkt dodany do \'$storageName\''),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            context.read<YourProductsCubit>().addYourProduct(
                                  productModel.productGroup,
                                  productModel.productName,
                                  productModel.productQuantity,
                                  storageName!,
                                );
                            context
                                .read<AddCubit>()
                                .delete(documentID: productModel.id);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              style: GoogleFonts.getFont('Saira',
                                  color: Colors.white),
                              'Dodaj'),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
