import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:shoplistapp/app/home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog/elevated_button_add_to_storage_widget.dart';

import 'package:shoplistapp/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:shoplistapp/app/models/product_model.dart';
import 'package:shoplistapp/app/repositories/purchased_products_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class AddToStorageAlertDialogWidget extends StatelessWidget {
  const AddToStorageAlertDialogWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    int quantityGram = 0;

    return BlocProvider(
      create: (context) => YourProductsCubit(PurchasedProductsRepository(
          PurchasedProductsRemoteDataSource(), UserRemoteDataSource()))
        ..start(),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          String? storageName;
          int productQuantity = productModel.productQuantity;
          bool isDated = false;
          String productTypeName = productModel.productTypeName;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: const Color.fromARGB(255, 200, 233, 255),
                title: Text(
                  style: GoogleFonts.getFont('Saira',
                      fontWeight: FontWeight.bold, color: Colors.black),
                  'Wybierz miejsce przechowywania',
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
                            (productModel.productTypeName != 'gramy')
                                ? setState(() {
                                    quantityGram = -1;
                                    storageName = newProduct!;
                                  })
                                : setState(() {
                                    quantityGram = 0;
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
                      Column(
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          (productTypeName != 'gramy')
                              ? Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 12, color: Colors.black),
                                  'Kupiona ilość: ')
                              : Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 12, color: Colors.black),
                                  'Kupiona ilość porcji: '),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: NumberPicker(
                              textStyle: GoogleFonts.getFont('Saira',
                                  fontSize: 16, color: Colors.black),
                              selectedTextStyle: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 0, 63, 114),
                                  fontWeight: FontWeight.bold),
                              itemHeight: 24,
                              itemWidth: 40,
                              axis: Axis.horizontal,
                              value: productQuantity,
                              minValue: 1,
                              maxValue: 100,
                              itemCount: 5,
                              onChanged: (value) =>
                                  setState(() => productQuantity = value),
                            ),
                          ),
                        ],
                      ),
                      (productTypeName != 'gramy')
                          ? Container()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 3,
                                ),
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
                                        'Wielkość porcji: ',
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
                                          quantityGram = (quantityGrams == null)
                                              ? 0
                                              : quantityGrams;
                                        },
                                      );
                                    },
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
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
                  ElevatedButtonAddToStorageWidget(
                    storageName: storageName,
                    productModel: productModel,
                    productQuantity: productQuantity,
                    isDated: isDated,
                    productTypeName: productTypeName,
                    productPortion: quantityGram,
                  ),
                ],
              );
            },
          );
        },
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
