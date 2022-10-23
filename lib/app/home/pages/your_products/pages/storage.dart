import 'package:ShopListApp/app/models/purchased_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ShopListApp/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:ShopListApp/app/repositories/purchased_products_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

class PurchasedProductsPage extends StatefulWidget {
  const PurchasedProductsPage({
    required this.storageName,
    Key? key,
  }) : super(key: key);
  final String storageName;

  @override
  State<PurchasedProductsPage> createState() => _PurchasedProductsPageState();
}

class _PurchasedProductsPageState extends State<PurchasedProductsPage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).viewPadding;
    double height1 = height - padding.top - padding.bottom - 130 - 55 - 100;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (() {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
                child: Container(
                  height: 35,
                  width: width * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (currentIndex == 0)
                        ? Colors.blue
                        : const Color.fromARGB(255, 0, 63, 114),
                  ),
                  child: const Icon(
                    Icons.kitchen_outlined,
                  ),
                ),
              ),
              InkWell(
                onTap: (() {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
                child: Container(
                  height: 35,
                  width: width * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (currentIndex == 1)
                        ? Colors.blue
                        : const Color.fromARGB(255, 0, 63, 114),
                  ),
                  child: const Icon(
                    Icons.ac_unit_rounded,
                  ),
                ),
              ),
              InkWell(
                onTap: (() {
                  setState(() {
                    currentIndex = 2;
                  });
                }),
                child: Container(
                  height: 35,
                  width: width * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (currentIndex == 2)
                        ? Colors.blue
                        : const Color.fromARGB(255, 0, 63, 114),
                  ),
                  child: const Icon(
                    Icons.local_laundry_service_outlined,
                  ),
                ),
              ),
              InkWell(
                onTap: (() {
                  setState(() {
                    currentIndex = 3;
                  });
                }),
                child: Container(
                  height: 35,
                  width: width * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (currentIndex == 3)
                        ? Colors.blue
                        : const Color.fromARGB(255, 0, 63, 114),
                  ),
                  child: const Icon(
                    Icons.door_sliding_outlined,
                  ),
                ),
              ),
              InkWell(
                onTap: (() {
                  setState(() {
                    currentIndex = 4;
                  });
                }),
                child: Container(
                  height: 35,
                  width: width * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (currentIndex == 4)
                        ? Colors.blue
                        : const Color.fromARGB(255, 0, 63, 114),
                  ),
                  child: const Icon(
                    Icons.more_horiz_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black, blurRadius: 3, offset: Offset(3, 3))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: height1,
                  child: Scaffold(
                    body: ListView(
                      children: [
                        (currentIndex == 0)
                            ? const _List(storageName: 'Lodówka')
                            : (currentIndex == 1)
                                ? const _List(storageName: 'Zamrażarka')
                                : (currentIndex == 2)
                                    ? const _List(
                                        storageName: 'Szafka kuchenna')
                                    : (currentIndex == 3)
                                        ? const _List(storageName: 'Chemia')
                                        : (currentIndex == 4)
                                            ? const _List(storageName: 'Inne')
                                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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
          return ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (final purchasedProductsModel in purchasedProductModels) ...[
                if (purchasedProductsModel.storageName ==
                    widget.storageName) ...[
                  const SizedBox(height: 7),
                  _OneProduct(
                    purchasedProductsModel: purchasedProductsModel,
                  ),
                ]
              ]
            ],
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 200, 233, 255),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(3, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            style: GoogleFonts.getFont(
                              'Saira',
                              color: const Color.fromARGB(255, 0, 63, 114),
                              fontWeight: FontWeight.bold,
                            ),
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
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 63, 114),
                                          ),
                                          onPressed: () async {
                                            showCupertinoModalPopup(
                                                context: context,
                                                builder:
                                                    (BuildContext builder) {
                                                  return CupertinoPopupSurface(
                                                    child: Container(
                                                        color: Colors.grey,
                                                        alignment:
                                                            Alignment.center,
                                                        width: double.infinity,
                                                        height: 150,
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                            'Wybierz termin ważności',
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Saira',
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors.grey[
                                                                            800]),
                                                            onPressed:
                                                                () async {
                                                              final DateTime? newDate = await showDatePicker(
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
                                                                color: Colors
                                                                    .black,
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
                                          child:
                                              const Icon(Icons.calendar_month),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 80,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 0, 63, 114),
                                            ),
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
                                                color: Colors.white,
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
                              if (widget
                                      .purchasedProductsModel.productTypeName !=
                                  'porcja (50 g)')
                                Text(
                                  '1 ${widget.purchasedProductsModel.productTypeName}',
                                  style: GoogleFonts.getFont(
                                    'Saira',
                                    fontSize: 8,
                                    color:
                                        const Color.fromARGB(255, 0, 63, 114),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              else
                                Text(
                                  '1 porcja (${widget.purchasedProductsModel.productPortion.toString()} gram)',
                                  style: GoogleFonts.getFont(
                                    'Saira',
                                    fontSize: 8,
                                    color:
                                        const Color.fromARGB(255, 0, 63, 114),
                                    fontWeight: FontWeight.bold,
                                  ),
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
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 63, 114),
        ),
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
