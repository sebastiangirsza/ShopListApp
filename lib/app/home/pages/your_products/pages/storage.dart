import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoplistapp/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:shoplistapp/app/models/purchased_product_model.dart';
import 'package:shoplistapp/app/repositories/purchased_products_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

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
  var title = 'Lodówka';

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height * 0.9) - 175;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              storageInkWell(0, 'Lodówka', const Icon(Icons.kitchen_outlined)),
              storageInkWell(
                  1, 'Zamrażarka', const Icon(Icons.ac_unit_rounded)),
              storageInkWell(2, 'Szafka kuchenna',
                  const Icon(Icons.door_sliding_outlined)),
              storageInkWell(3, 'Chemia',
                  const Icon(Icons.local_laundry_service_outlined)),
              storageInkWell(
                  4, 'Spiżarnia', const Icon(Icons.door_front_door_outlined)),
              storageInkWell(5, 'Inne', const Icon(Icons.more_horiz_outlined)),
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
                  height: height,
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          title,
                          style: GoogleFonts.getFont(
                            'Saira',
                            color: const Color.fromARGB(255, 0, 63, 114),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      (currentIndex == 0)
                          ? const _List(storageName: 'Lodówka')
                          : (currentIndex == 1)
                              ? const _List(storageName: 'Zamrażarka')
                              : (currentIndex == 2)
                                  ? const _List(storageName: 'Szafka kuchenna')
                                  : (currentIndex == 3)
                                      ? const _List(storageName: 'Chemia')
                                      : (currentIndex == 4)
                                          ? const _List(
                                              storageName: 'Spiżarnia')
                                          : (currentIndex == 5)
                                              ? const _List(storageName: 'Inne')
                                              : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget storageInkWell(int index, String titles, Icon icon) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() {
        setState(() {
          currentIndex = index;
          title = titles;
        });
      }),
      child: Container(
        height: 35,
        width: width * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: (currentIndex == index)
              ? Colors.blue
              : const Color.fromARGB(255, 0, 63, 114),
        ),
        child: icon,
      ),
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
                decoration: (widget.purchasedProductsModel.frozen != true)
                    ? (widget.purchasedProductsModel.isDated == true)
                        ? (widget.purchasedProductsModel.daysLeft() < 0)
                            ? daysLeftColors(
                                const Color.fromARGB(255, 255, 17, 0))
                            : (widget.purchasedProductsModel.daysLeft() >= 0 &&
                                    widget.purchasedProductsModel.daysLeft() <=
                                        3)
                                ? daysLeftColors(
                                    const Color.fromARGB(255, 255, 245, 150))
                                : daysLeftColors(
                                    const Color.fromARGB(255, 143, 255, 147))
                        : daysLeftColors(
                            const Color.fromARGB(255, 200, 233, 255))
                    : daysLeftColors(Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
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
                                        width: 85,
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
                                                  return CupertinoPopupSurfaceWidget(
                                                    purchasedProductsModel: widget
                                                        .purchasedProductsModel,
                                                  );
                                                });
                                          },
                                          child:
                                              const Icon(Icons.calendar_month),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 85,
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
                                                        DateTime(2101),
                                                  );
                                              setState(() {
                                                isDated = !isDated;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                (widget.purchasedProductsModel
                                                            .frozen ==
                                                        true)
                                                    ? const Icon(
                                                        Icons.ac_unit_rounded,
                                                        size: 11)
                                                    : const Icon(null, size: 0),
                                                Text(
                                                  widget.purchasedProductsModel
                                                      .dateFormatted(),
                                                  style: GoogleFonts.getFont(
                                                    'Saira',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                              ]),
                            ],
                          ),
                          if (widget.purchasedProductsModel.productTypeName !=
                              'gramy')
                            Text(
                              '1 ${widget.purchasedProductsModel.productTypeName}',
                              style: GoogleFonts.getFont(
                                'Saira',
                                fontSize: 8,
                                color: const Color.fromARGB(255, 0, 63, 114),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          else
                            Text(
                              '1 porcja (${widget.purchasedProductsModel.productPortion.toString()} gram)',
                              style: GoogleFonts.getFont(
                                'Saira',
                                fontSize: 8,
                                color: const Color.fromARGB(255, 0, 63, 114),
                                fontWeight: FontWeight.bold,
                              ),
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

BoxDecoration daysLeftColors(Color elementColor) {
  return BoxDecoration(
    color: elementColor,
    borderRadius: BorderRadius.circular(15),
    boxShadow: const <BoxShadow>[
      BoxShadow(
        color: Colors.black,
        blurRadius: 2,
        offset: Offset(3, 3),
      )
    ],
  );
}

class CupertinoPopupSurfaceWidget extends StatefulWidget {
  const CupertinoPopupSurfaceWidget({
    required this.purchasedProductsModel,
    Key? key,
  }) : super(key: key);
  final PurchasedProductModel purchasedProductsModel;

  @override
  State<CupertinoPopupSurfaceWidget> createState() =>
      _CupertinoPopupSurfaceWidgetState();
}

class _CupertinoPopupSurfaceWidgetState
    extends State<CupertinoPopupSurfaceWidget> {
  DateTime? purchasedProductDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(PurchasedProductsRepository(
          PurchasedProductsRemoteDataSource(), UserRemoteDataSource())),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          return CupertinoPopupSurface(
            child: Container(
                color: const Color.fromARGB(255, 200, 233, 255),
                alignment: Alignment.center,
                width: double.infinity,
                height: 170,
                child: Column(children: [
                  Text(
                    'Wybierz termin ważności',
                    style: GoogleFonts.getFont(
                      'Saira',
                      fontSize: 20,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                      ),
                      onPressed: () async {
                        final DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));
                        if (newDate != null &&
                            newDate != purchasedProductDate) {
                          setState(() {
                            purchasedProductDate = newDate;
                          });
                        }
                      },
                      child: Text(
                        DateFormat('dd/MM/yy').format(purchasedProductDate!),
                        style: GoogleFonts.getFont(
                          'Saira',
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      context.read<YourProductsCubit>().isDated(
                          isDated: true,
                          documentID: widget.purchasedProductsModel.id,
                          purchasedProductDate: purchasedProductDate!);

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
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      backgroundColor: const Color.fromARGB(255, 200, 233, 255),
                      title: Text(
                        style: GoogleFonts.getFont('Saira',
                            fontWeight: FontWeight.bold, color: Colors.black),
                        'Wybierz nowe miejsce przechowywania',
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                  style: GoogleFonts.getFont('Saira',
                                      color: Colors.black, fontSize: 12),
                                  'Miejsce przechowywania')),
                          borderRadius: BorderRadius.circular(10),
                          iconDisabledColor: Colors.black,
                          iconEnabledColor: Colors.black,
                          dropdownColor: Colors.white,
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
                            'Spiżarnia',
                            'Inne',
                          ].map<DropdownMenuItem<String>>(
                            (storageName) {
                              return DropdownMenuItem<String>(
                                value: storageName,
                                child: Center(
                                  child: Text(
                                    style: GoogleFonts.getFont('Saira',
                                        color: Colors.black, fontSize: 12),
                                    storageName,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
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
                                        frozen: (storageName == 'Zamrażarka'
                                            ? true
                                            : (widget.purchasedProductsModel
                                                        .frozen ==
                                                    true)
                                                ? true
                                                : false),
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
