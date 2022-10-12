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
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 63, 114),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black, blurRadius: 5)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          style: GoogleFonts.getFont('Saira'),
                          widget.purchasedProductsModel.purchasedProductName),
                    ),
                    const SizedBox(width: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _UpdateStorageWidget(widget: widget),
                            const SizedBox(width: 2),
                            Column(children: [
                              (widget.purchasedProductsModel.isDated == false)
                                  ? SizedBox(
                                      width: 80,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext builder) {
                                                return CupertinoPopupSurface(
                                                  child: Container(
                                                      color: Colors.grey,
                                                      alignment:
                                                          Alignment.center,
                                                      width: double.infinity,
                                                      height: 150,
                                                      child: Column(children: [
                                                        Text(
                                                          'Wybierz termin ważności',
                                                          style: GoogleFonts
                                                              .getFont(
                                                            'Saira',
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          800]),
                                                          onPressed: () async {
                                                            final DateTime? newDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime
                                                                            .now(),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2100));
                                                            if (newDate !=
                                                                    null &&
                                                                newDate !=
                                                                    purchasedProductDate) {
                                                              setState(() {
                                                                purchasedProductDate =
                                                                    newDate;
                                                              });
                                                            }
                                                          },
                                                          child: const Icon(Icons
                                                              .calendar_month),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            context.read<YourProductsCubit>().isDated(
                                                                isDated: true,
                                                                documentID: widget
                                                                    .purchasedProductsModel
                                                                    .id,
                                                                purchasedProductDate:
                                                                    purchasedProductDate!);

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Zapisz',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Saira',
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ])),
                                                );
                                              });
                                        },
                                        child: const Icon(Icons.calendar_month),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 80,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<YourProductsCubit>()
                                                .isDated(
                                                  isDated: false,
                                                  documentID: widget
                                                      .purchasedProductsModel
                                                      .id,
                                                  purchasedProductDate:
                                                      DateTime(2000),
                                                );
                                            setState(() {
                                              isDated = !isDated;
                                            });
                                          },
                                          child: Text(
                                            widget.purchasedProductsModel
                                                .dateFormatted(),
                                            style: GoogleFonts.getFont(
                                              'Saira',
                                              fontSize: 10,
                                              color: Colors.black,
                                              decoration: TextDecoration.none,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ),
                            ]),
                          ],
                        ),
                        Column(
                          children: [
                            if (widget.purchasedProductsModel.productTypeName !=
                                'porcja (50 g)')
                              Text(
                                '1 ${widget.purchasedProductsModel.productTypeName}',
                                style:
                                    GoogleFonts.getFont('Saira', fontSize: 8),
                              )
                            else
                              Text(
                                '1 porcja (${widget.purchasedProductsModel.productPortion.toString()} gram)',
                                style:
                                    GoogleFonts.getFont('Saira', fontSize: 8),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    )
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

class _UpdateStorageWidget extends StatelessWidget {
  const _UpdateStorageWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final _OneProduct widget;

  @override
  Widget build(BuildContext context) {
    String? storageName;
    return SizedBox(
      width: 45,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                      title: Text(
                        style: GoogleFonts.getFont('Saira',
                            fontWeight: FontWeight.bold),
                        'Wybierz nowe miejsce przechowywania',
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
                              style: GoogleFonts.getFont('Saira',
                                  color: Colors.black),
                            )),
                        BlocProvider(
                          create: (context) => YourProductsCubit(
                              PurchasedProductsRepository(
                                  PurchasedProductsRemoteDataSource(),
                                  UserRemoteDataSource())),
                          child:
                              BlocBuilder<YourProductsCubit, YourProductsState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 600),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              style: GoogleFonts.getFont(
                                                  'Saira',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              'Produkt przeniesiony do \'$storageName\''),
                                        ],
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  context
                                      .read<YourProductsCubit>()
                                      .updateStorage(
                                        storageName: storageName!,
                                        documentID:
                                            widget.purchasedProductsModel.id,
                                      );
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
              });
        },
        child: const Icon(
          Icons.read_more,
          size: 14,
        ),
      ),
    );
  }
}
