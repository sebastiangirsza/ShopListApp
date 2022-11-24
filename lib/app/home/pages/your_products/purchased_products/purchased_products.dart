import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shoplistapp/app/home/pages/your_products/cubit/purchased_products_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';
import 'package:shoplistapp/app/models/purchased_product_model.dart';

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
  var storageNames = 'Lodówka';

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
              storageInkWell(
                0,
                'Lodówka',
                const Icon(Icons.kitchen_outlined),
              ),
              storageInkWell(
                1,
                'Zamrażarka',
                const Icon(Icons.ac_unit_rounded),
              ),
              storageInkWell(
                2,
                'Szafka kuchenna',
                const Icon(Icons.door_sliding_outlined),
              ),
              storageInkWell(
                3,
                'Chemia',
                const Icon(Icons.local_laundry_service_outlined),
              ),
              storageInkWell(
                4,
                'Spiżarnia',
                const Icon(Icons.door_front_door_outlined),
              ),
              storageInkWell(
                5,
                'Inne',
                const Icon(Icons.more_horiz_outlined),
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
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white,
                ),
                height: height,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
                      child: ListView(
                        children: [
                          (currentIndex == 0)
                              ? const Lists(storageName: 'Lodówka')
                              : (currentIndex == 1)
                                  ? const Lists(storageName: 'Zamrażarka')
                                  : (currentIndex == 2)
                                      ? const Lists(
                                          storageName: 'Szafka kuchenna')
                                      : (currentIndex == 3)
                                          ? const Lists(storageName: 'Chemia')
                                          : (currentIndex == 4)
                                              ? const Lists(
                                                  storageName: 'Spiżarnia')
                                              : (currentIndex == 5)
                                                  ? const Lists(
                                                      storageName: 'Inne')
                                                  : Container(),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color.fromARGB(255, 0, 63, 114),
                      ),
                      child: Stack(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                storageNames,
                                style: GoogleFonts.getFont(
                                  'Saira',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AddPurchasedProductWidget(
                                storageNames: storageNames,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget storageInkWell(int index, String storageName, Icon icon) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: (() {
        setState(() {
          currentIndex = index;
          storageNames = storageName;
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

@injectable
class AddPurchasedProductWidget extends StatelessWidget {
  const AddPurchasedProductWidget({
    required this.storageNames,
    Key? key,
  }) : super(key: key);
  final String storageNames;

  @override
  Widget build(BuildContext context) {
    DateTime? productDate = DateTime(2100);
    bool isDated = false;
    String? productName;
    String? productGroup;
    int quantityGram = 0;
    int productQuantity = 1;
    String? productTypeName;
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: const Color.fromARGB(255, 200, 233, 255),
                title: Text(
                  style: GoogleFonts.getFont('Saira',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 12),
                  'Dodaj produkt do $storageNames',
                  textAlign: TextAlign.center,
                ),
                content: Container(
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          decoration: boxDecoration(),
                          child: TextField(
                            style: GoogleFonts.getFont(
                              'Saira',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelStyle: GoogleFonts.getFont(
                                'Saira',
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Nazwa produktu',
                              ),
                            ),
                            onChanged: (newProduct) {
                              setState(() {
                                productName = newProduct;
                              });
                            },
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          decoration: boxDecoration(),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              label: Text(
                                'Kategoria',
                                style: GoogleFonts.getFont('Saira',
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                            iconDisabledColor: Colors.black,
                            iconEnabledColor: Colors.black,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: productGroup,
                            onChanged: (newProduct) {
                              setState(() {
                                productGroup = newProduct!;
                              });
                            },
                            items: <String>[
                              'Warzywa',
                              'Owoce',
                              'Mięso',
                              'Pieczywo',
                              'Suche produkty',
                              'Nabiał',
                              'Chemia',
                              'Przekąski',
                              'Napoje',
                              'Inne',
                            ].map<DropdownMenuItem<String>>(
                              (productGroup) {
                                return DropdownMenuItem<String>(
                                  value: productGroup,
                                  child: Center(
                                    child: Text(
                                      style: GoogleFonts.getFont(
                                        'Saira',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      productGroup,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          decoration: boxDecoration(),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              label: Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 12, color: Colors.black),
                                  'Rodzaj opakowania'),
                              border: InputBorder.none,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            iconDisabledColor: Colors.black,
                            iconEnabledColor: Colors.black,
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: productTypeName,
                            onChanged: (newProduct) {
                              setState(() {
                                productTypeName = newProduct!;
                                (productTypeName != 'gramy')
                                    ? quantityGram = -1
                                    : quantityGram = 0;
                              });
                            },
                            items: <String>[
                              'sztuka',
                              'karton',
                              'gramy',
                              'paczka',
                              'butelka',
                              'słoik',
                            ].map<DropdownMenuItem<String>>(
                              (productTypeName) {
                                return DropdownMenuItem<String>(
                                  value: productTypeName,
                                  child: Center(
                                    child: Text(
                                      style: GoogleFonts.getFont(
                                        'Saira',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      productTypeName,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        const SizedBox(height: 2),
                        (productTypeName != 'gramy')
                            ? Container(height: 0)
                            : Container(
                                decoration: boxDecoration(),
                                child: Column(
                                  children: [
                                    Text(
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 12, color: Colors.black),
                                        'Ilość porcji: '),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: NumberPicker(
                                        textStyle: GoogleFonts.getFont('Saira',
                                            fontSize: 16, color: Colors.black),
                                        selectedTextStyle: GoogleFonts.getFont(
                                            'Saira',
                                            fontSize: 20,
                                            color: const Color.fromARGB(
                                                255, 0, 63, 114),
                                            fontWeight: FontWeight.bold),
                                        itemHeight: 24,
                                        itemWidth: 40,
                                        axis: Axis.horizontal,
                                        value: productQuantity,
                                        minValue: 1,
                                        maxValue: 100,
                                        itemCount: 5,
                                        onChanged: (value) => setState(
                                            () => productQuantity = value),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(height: 2),
                        (productTypeName != null)
                            ? (productTypeName != 'gramy')
                                ? Container(
                                    decoration: boxDecoration(),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                            style: GoogleFonts.getFont('Saira',
                                                fontSize: 12,
                                                color: Colors.black),
                                            'Ilość: '),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: NumberPicker(
                                            textStyle: GoogleFonts.getFont(
                                                'Saira',
                                                fontSize: 16,
                                                color: Colors.black),
                                            selectedTextStyle:
                                                GoogleFonts.getFont('Saira',
                                                    fontSize: 20,
                                                    color: const Color.fromARGB(
                                                        255, 0, 63, 114),
                                                    fontWeight:
                                                        FontWeight.bold),
                                            itemHeight: 24,
                                            itemWidth: 40,
                                            axis: Axis.horizontal,
                                            value: productQuantity,
                                            minValue: 1,
                                            maxValue: 100,
                                            itemCount: 5,
                                            onChanged: (value) => setState(() {
                                              productQuantity = value;
                                            }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    decoration: boxDecoration(),
                                    child: TextField(
                                      style: GoogleFonts.getFont(
                                        'Saira',
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle: GoogleFonts.getFont(
                                          'Saira',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                        label: const Text(
                                          'Ilość gram',
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (newQuantityGram) {
                                        final quantityGrams =
                                            int.tryParse(newQuantityGram);
                                        setState(
                                          () {
                                            quantityGram =
                                                (quantityGrams == null)
                                                    ? 0
                                                    : quantityGrams;
                                          },
                                        );
                                      },
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                            : Container(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      productGroup = null;
                                      productTypeName = null;
                                      productQuantity = 1;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Anuluj',
                                    style: GoogleFonts.getFont('Saira',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: BlocProvider(
                                create: (context) => getIt<YourProductsCubit>(),
                                child: BlocBuilder<YourProductsCubit,
                                    YourProductsState>(
                                  builder: (context, state) {
                                    return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black),
                                        onPressed: productName == null ||
                                                productGroup == null ||
                                                productTypeName == null
                                            ? null
                                            : () {
                                                List<String> listaProcura = [];
                                                String temp = "";
                                                for (var i = 0;
                                                    i < productName!.length;
                                                    i++) {
                                                  if (productName![i] == " ") {
                                                    temp = "";
                                                  } else {
                                                    temp =
                                                        temp + productName![i];
                                                    listaProcura.add(
                                                        temp.toLowerCase());
                                                  }
                                                }
                                                final int count =
                                                    productQuantity;
                                                final bool frozen =
                                                    (storageNames ==
                                                            'Zamrażarka'
                                                        ? true
                                                        : false);

                                                for (var i = 0;
                                                    i < count;
                                                    i++) {
                                                  context
                                                      .read<YourProductsCubit>()
                                                      .addYourProduct(
                                                        productGroup!,
                                                        productName!,
                                                        productDate,
                                                        storageNames,
                                                        isDated,
                                                        listaProcura,
                                                        productTypeName!,
                                                        quantityGram,
                                                        frozen,
                                                      );
                                                }
                                                setState(() {
                                                  productGroup = null;
                                                  productTypeName = null;
                                                  productQuantity = 1;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                        child: Text(
                                          'Dodaj',
                                          style: GoogleFonts.getFont('Saira',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              );
            });
          }),
      child: Container(
        height: 32,
        width: 32,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Colors.white),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 0, 63, 114),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white.withOpacity(0.5),
    );
  }
}

@injectable
class Lists extends StatefulWidget {
  const Lists({
    Key? key,
    required this.storageName,
  }) : super(key: key);

  final String storageName;

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<YourProductsCubit>()..start(),
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
                  OneProduct(
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

@injectable
class OneProduct extends StatefulWidget {
  const OneProduct({
    Key? key,
    required this.purchasedProductsModel,
  }) : super(key: key);

  final PurchasedProductModel purchasedProductsModel;

  @override
  State<OneProduct> createState() => _OneProductState();
}

class _OneProductState extends State<OneProduct> {
  var isDated = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<YourProductsCubit>(),
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
                              UpdateStorageWidget(widget: widget),
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
                                                  return AddDateWidget(
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
                                            onPressed: () => showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return DeleteDateAlertDialog(
                                                        isDated: isDated,
                                                        purchasedProductModel:
                                                            widget
                                                                .purchasedProductsModel);
                                                  },
                                                ),
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
                            UpdateProductQuantityGram(
                                purchasedProductModel:
                                    widget.purchasedProductsModel),
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

@injectable
class UpdateProductQuantityGram extends StatelessWidget {
  const UpdateProductQuantityGram({
    Key? key,
    required this.purchasedProductModel,
  }) : super(key: key);

  final PurchasedProductModel purchasedProductModel;

  @override
  Widget build(BuildContext context) {
    int quantityGram = purchasedProductModel.productPortion;
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: const Color.fromARGB(255, 200, 233, 255),
                title: Text(
                  'Zmień wielkość porcji',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont('Saira',
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                content: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: Container(
                        decoration: boxDecoration(),
                        child: TextField(
                          style: GoogleFonts.getFont(
                            'Saira',
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelStyle: GoogleFonts.getFont(
                              'Saira',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Wielkość porcji: ',
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (newQuantityGram) {
                            final quantityGrams = int.tryParse(newQuantityGram);
                            setState(
                              () {
                                quantityGram =
                                    (quantityGrams == null) ? 0 : quantityGrams;
                              },
                            );
                          },
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Anuluj',
                              style: GoogleFonts.getFont('Saira',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        BlocProvider(
                          create: (context) => getIt<YourProductsCubit>(),
                          child:
                              BlocBuilder<YourProductsCubit, YourProductsState>(
                            builder: (context, state) {
                              return Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {
                                    context
                                        .read<YourProductsCubit>()
                                        .updatePortion(
                                          documentID: purchasedProductModel.id,
                                          productPortion: quantityGram,
                                        );

                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Potwierdź',
                                    style: GoogleFonts.getFont('Saira',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              );
            });
          }),
      child: Row(
        children: [
          const Icon(
            Icons.edit,
            size: 13,
            color: Colors.black,
          ),
          const SizedBox(width: 3),
          Text(
            '1 porcja (${purchasedProductModel.productPortion.toString()} gram)',
            style: GoogleFonts.getFont(
              'Saira',
              fontSize: 8,
              color: const Color.fromARGB(255, 0, 63, 114),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white.withOpacity(0.5),
    );
  }
}

class DeleteDateAlertDialog extends StatelessWidget {
  const DeleteDateAlertDialog({
    Key? key,
    required this.isDated,
    required this.purchasedProductModel,
  }) : super(key: key);

  final bool isDated;
  final PurchasedProductModel purchasedProductModel;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: const Color.fromARGB(255, 200, 233, 255),
          title: Text(
            'Czy chcesz trwale usunąć datę ważności?',
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont('Saira',
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          content: Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Nie',
                          style: GoogleFonts.getFont('Saira',
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DeleteDateElevatedButton(
                      isDated: isDated,
                      purchasedProductModel: purchasedProductModel,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

@injectable
class DeleteDateElevatedButton extends StatefulWidget {
  const DeleteDateElevatedButton({
    required this.purchasedProductModel,
    required this.isDated,
    super.key,
  });

  final PurchasedProductModel purchasedProductModel;
  final bool isDated;

  @override
  State<DeleteDateElevatedButton> createState() =>
      _DeleteDateElevatedButtonState();
}

class _DeleteDateElevatedButtonState extends State<DeleteDateElevatedButton> {
  @override
  Widget build(BuildContext context) {
    bool isDated = widget.isDated;
    return BlocProvider(
      create: (context) => getIt<YourProductsCubit>(),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          return Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.read<YourProductsCubit>().isDated(
                      isDated: false,
                      documentID: widget.purchasedProductModel.id,
                      purchasedProductDate: DateTime(2101),
                    );
                setState(() {
                  isDated = !isDated;
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Tak',
                style: GoogleFonts.getFont('Saira',
                    fontWeight: FontWeight.bold, color: Colors.white),
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

@injectable
class AddDateWidget extends StatefulWidget {
  const AddDateWidget({
    required this.purchasedProductsModel,
    Key? key,
  }) : super(key: key);
  final PurchasedProductModel purchasedProductsModel;

  @override
  State<AddDateWidget> createState() => _AddDateWidgetState();
}

class _AddDateWidgetState extends State<AddDateWidget> {
  DateTime? purchasedProductDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<YourProductsCubit>(),
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

@injectable
class UpdateStorageWidget extends StatelessWidget {
  const UpdateStorageWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final OneProduct widget;

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
                          create: (context) => getIt<YourProductsCubit>(),
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
