import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shoplistapp/app/home/pages/shop_list/cubit/add_product_cubit.dart';
import 'package:shoplistapp/app/repositories/products_repositories.dart';
import 'package:shoplistapp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  String? productGroup;
  String? productName;
  String? productTypeName;
  int productQuantity = 1;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            elevation: 15,
            backgroundColor: const Color.fromARGB(255, 0, 63, 114),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)))),
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  backgroundColor: const Color.fromARGB(255, 200, 233, 255),
                  content: SizedBox(
                    height: 270,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Text(
                          style: GoogleFonts.getFont('Saira',
                              fontWeight: FontWeight.bold, color: Colors.black),
                          'Dodaj produkt do listy',
                          textAlign: TextAlign.center,
                        ),
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
                              'Mięso',
                              'Pieczywo',
                              'Suche produkty',
                              'Nabiał',
                              'Chemia',
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
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white.withOpacity(0.5),
                          ),
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
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 12, color: Colors.black),
                                  'Ilość: '),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: NumberPicker(
                                  textStyle: GoogleFonts.getFont('Saira',
                                      fontSize: 16, color: Colors.black),
                                  selectedTextStyle: GoogleFonts.getFont(
                                      'Saira',
                                      fontSize: 20,
                                      color:
                                          const Color.fromARGB(255, 0, 63, 114),
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
                        ),
                        const SizedBox(height: 2),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.white.withOpacity(0.5),
                          ),
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
                              });
                            },
                            items: <String>[
                              'sztuka',
                              'karton',
                              'porcja (50 g)',
                              'paczka',
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
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            productGroup = null;
                            productName = null;
                            productQuantity = 1;
                            productTypeName = null;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cofnij',
                          style: GoogleFonts.getFont('Saira',
                              color: const Color.fromARGB(255, 0, 63, 114),
                              fontWeight: FontWeight.bold),
                        )),
                    BlocProvider(
                      create: (context) => AddProductCubit(ProductsRepository(
                          ProductRemoteDataSource(), UserRemoteDataSource())),
                      child: BlocBuilder<AddProductCubit, AddProductState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: productGroup == null ||
                                    productName == null ||
                                    productTypeName == null
                                ? null
                                : () {
                                    context.read<AddProductCubit>().add(
                                          productGroup!,
                                          productName!,
                                          productQuantity,
                                          isChecked,
                                          productTypeName!,
                                        );
                                    setState(() {
                                      productGroup = null;
                                      productName = null;
                                      productQuantity = 1;
                                      productTypeName = null;
                                    });

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
                                                'Produkt dodany do listy'),
                                          ],
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  },
                            child: Text(
                                style: GoogleFonts.getFont('Saira'),
                                'Dodaj do listy'),
                          );
                        },
                      ),
                    )
                  ],
                );
              });
            }),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                style: GoogleFonts.getFont('Saira',
                    color: Colors.white, fontWeight: FontWeight.bold),
                'Dodaj produkt do listy'),
            const SizedBox(width: 5),
            const Icon(Icons.add, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
