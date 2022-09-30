import 'package:ShopListApp/app/models/purchased_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ShopListApp/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:ShopListApp/app/repositories/purchased_products_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

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
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              expandedHeight: 90,
              snap: false,
              pinned: true,
              floating: false,
              forceElevated: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                          style: GoogleFonts.getFont('Saira',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                          storageName),
                    ),
                  ],
                ),
              ),
              title: Text(
                  style: GoogleFonts.getFont('Saira',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                  'Shop List'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _List(storageName: storageName),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class _List extends StatefulWidget {
  const _List({
    Key? key,
    required this.storageName,
  }) : super(key: key);

  final String storageName;

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(PurchasedProductsRepository(
          PurchasedProductsRemoteDataSource(), UserRemoteDataSource()))
        ..start(),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          final purchasedProductModels = state.purchasedProducts;
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                for (final purchasedProductsModel
                    in purchasedProductModels) ...[
                  if (purchasedProductsModel.storageName ==
                      widget.storageName) ...[
                    const SizedBox(height: 7),
                    _OneProduct(
                      purchasedProductsModel: purchasedProductsModel,
                    ),
                  ]
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OneProduct extends StatefulWidget {
  const _OneProduct({
    Key? key,
    required this.purchasedProductsModel,
  }) : super(key: key);

  final PurchasedProductModel purchasedProductsModel;

  @override
  State<_OneProduct> createState() => _OneProductState();
}

class _OneProductState extends State<_OneProduct> {
  var isDated = true;
  DateTime? purchasedProductDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(PurchasedProductsRepository(
          PurchasedProductsRemoteDataSource(), UserRemoteDataSource())),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          return Dismissible(
            key: UniqueKey(),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                context.read<YourProductsCubit>().deletePurchasedProduct(
                    documentID: widget.purchasedProductsModel.id);
              }
              return null;
            },
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 63, 114),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black, blurRadius: 5)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        style: GoogleFonts.getFont('Saira'),
                        widget.purchasedProductsModel.purchasedProductName),
                    Row(children: [
                      if (widget.purchasedProductsModel.isDated == true)
                        Text(
                            style: GoogleFonts.getFont('Saira'),
                            widget.purchasedProductsModel.dateFormatted()),
                      const SizedBox(width: 10),
                      (widget.purchasedProductsModel.isDated == false)
                          ? ElevatedButton(
                              onPressed: () async {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return CupertinoPopupSurface(
                                        child: Container(
                                            color: Colors.grey,
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            height: 150,
                                            child: Column(children: [
                                              Text(
                                                'Wybierz termin ważności',
                                                style: GoogleFonts.getFont(
                                                  'Saira',
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey[800]),
                                                onPressed: () async {
                                                  final DateTime? newDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2100));
                                                  if (newDate != null &&
                                                      newDate !=
                                                          purchasedProductDate) {
                                                    setState(() {
                                                      purchasedProductDate =
                                                          newDate;
                                                    });
                                                  }
                                                },
                                                child: const Icon(
                                                    Icons.calendar_month),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<YourProductsCubit>()
                                                      .isDated(
                                                          isDated: true,
                                                          documentID: widget
                                                              .purchasedProductsModel
                                                              .id,
                                                          purchasedProductDate:
                                                              purchasedProductDate!);

                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                  'Zapisz',
                                                  style: GoogleFonts.getFont(
                                                    'Saira',
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ])),
                                      );
                                    });
                              },
                              child: const Icon(Icons.calendar_month),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                context.read<YourProductsCubit>().isDated(
                                      isDated: false,
                                      documentID:
                                          widget.purchasedProductsModel.id,
                                      purchasedProductDate: DateTime(2000),
                                    );
                                setState(() {
                                  isDated = !isDated;
                                });
                              },
                              child: const Icon(Icons.delete))
                    ])
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
