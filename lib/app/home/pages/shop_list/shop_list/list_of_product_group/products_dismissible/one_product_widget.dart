import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shoplistapp/app/home/pages/shop_list/cubit/add_product_cubit.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart';
import 'package:shoplistapp/app/injection_container.dart';
import 'package:shoplistapp/app/models/product_model.dart';

class OneProductWidget extends StatefulWidget {
  const OneProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<OneProductWidget> createState() => _OneProductWidgetState();
}

class _OneProductWidgetState extends State<OneProductWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return ChangeQuantityAlertDialog(productModel: widget.productModel);
          }),
      child: Container(
        decoration: (widget.productModel.isChecked == false)
            ? const BoxDecoration(
                color: Color.fromARGB(255, 200, 233, 255),
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
              Flexible(
                child: Text(
                  widget.productModel.productName,
                  style: GoogleFonts.getFont(
                    'Saira',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    (widget.productModel.productTypeName != 'gramy')
                        ? widget.productModel.productQuantity.toString()
                        : '${widget.productModel.quantityGram.toString()} g',
                    style: GoogleFonts.getFont(
                      'Saira',
                      fontSize: (widget.productModel.productTypeName == 'gramy')
                          ? 8
                          : 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        (widget.productModel.isChecked == true)
                            ? showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AddToStorageAlertDialogWidget(
                                      productModel: widget.productModel);
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
                      },
                      child: const Icon(
                          size: 17,
                          color: Colors.white,
                          Icons.shopping_bag_outlined),
                    ),
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

@injectable
class ChangeQuantityAlertDialog extends StatefulWidget {
  const ChangeQuantityAlertDialog({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  State<ChangeQuantityAlertDialog> createState() =>
      _ChangeQuantityAlertDialogState();
}

class _ChangeQuantityAlertDialogState extends State<ChangeQuantityAlertDialog> {
  @override
  Widget build(BuildContext context) {
    int productQuantity = widget.productModel.productQuantity;
    String productName = widget.productModel.productName;
    String productTypeName = widget.productModel.productTypeName;
    int quantityGram = 0;
    bool changeName = false;
    bool changeProductTypeName = false;
    bool changeQuantity = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: const Color.fromARGB(255, 200, 233, 255),
          content: Container(
            constraints: const BoxConstraints(maxHeight: double.infinity),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                    style: GoogleFonts.getFont('Saira',
                        fontWeight: FontWeight.bold, color: Colors.black),
                    'Edytuj produkt z listy',
                    textAlign: TextAlign.center),
                (changeName == false)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: boxDecoration(),
                              child: Center(
                                child: Text(
                                  productName,
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  changeName = true;
                                });
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: boxDecoration(),
                                  child: TextField(
                                      style: GoogleFonts.getFont('Saira',
                                          fontSize: 12, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle: GoogleFonts.getFont('Saira',
                                            fontSize: 12, color: Colors.black),
                                        label: const Text('Nazwa produktu'),
                                      ),
                                      onChanged: (newProduct) {
                                        setState(() {
                                          productName = newProduct;
                                        });
                                      },
                                      textAlign: TextAlign.center))),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  changeName = false;
                                });
                              },
                              icon: const Icon(Icons.save))
                        ],
                      ),
                const SizedBox(height: 2),
                (changeProductTypeName == false)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 64,
                              decoration: boxDecoration(),
                              child: Center(
                                child: Text(
                                  productTypeName.toString(),
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  changeProductTypeName = true;
                                  changeQuantity = true;
                                });
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: boxDecoration(),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    label: Text(
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 12, color: Colors.black),
                                        'Rodzaj opakowania'),
                                    border: InputBorder.none),
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
                                                  color: Colors.black),
                                              productTypeName)),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  changeProductTypeName = false;
                                });
                              },
                              icon: const Icon(Icons.save))
                        ],
                      ),
                const SizedBox(height: 2),
                if (productTypeName != 'gramy')
                  if (changeQuantity == false)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 57,
                            decoration: boxDecoration(),
                            child: Center(
                              child: Text(
                                productQuantity.toString(),
                                style: GoogleFonts.getFont('Saira',
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                changeQuantity = true;
                              });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: boxDecoration(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                      style: GoogleFonts.getFont('Saira',
                                          fontSize: 12, color: Colors.black),
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
                                                  fontWeight: FontWeight.bold),
                                          itemHeight: 24,
                                          itemWidth: 40,
                                          axis: Axis.horizontal,
                                          value: productQuantity,
                                          minValue: 1,
                                          maxValue: 100,
                                          itemCount: 5,
                                          onChanged: (value) => setState(() {
                                                productQuantity = value;
                                              })))
                                ],
                              )),
                        ),
                        IconButton(
                            onPressed: changeProductTypeName == true
                                ? null
                                : () {
                                    setState(() {
                                      changeQuantity = false;
                                    });
                                  },
                            icon: const Icon(Icons.save))
                      ],
                    )
                else if (changeQuantity == false)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: boxDecoration(),
                          child: Center(
                            child: Text(
                              quantityGram.toString(),
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              changeQuantity = true;
                            });
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: boxDecoration(),
                          child: TextField(
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 12, color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelStyle: GoogleFonts.getFont('Saira',
                                    fontSize: 12, color: Colors.black),
                                label: const Text('Ilość gram'),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (newQuantityGram) {
                                final quantityGrams =
                                    int.tryParse(newQuantityGram);
                                setState(() {
                                  quantityGram = (quantityGrams == null)
                                      ? 0
                                      : quantityGrams;
                                });
                              },
                              textAlign: TextAlign.center),
                        ),
                      ),
                      IconButton(
                          onPressed: changeProductTypeName == true
                              ? null
                              : () {
                                  setState(() {
                                    changeQuantity = false;
                                  });
                                },
                          icon: const Icon(Icons.save))
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
                  'Anuluj',
                  style: GoogleFonts.getFont('Saira',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            BlocProvider(
              create: (context) => getIt<AddProductCubit>(),
              child: BlocBuilder<AddProductCubit, AddProductState>(
                builder: (context, state) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        context.read<AddProductCubit>().updateProduct(
                              documentID: widget.productModel.id,
                              productQuantity: productQuantity,
                              productName: productName,
                              productTypeName: productTypeName,
                              quantityGram: quantityGram,
                            );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Potwierdź'));
                },
              ),
            ),
          ]);
    });
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white.withOpacity(0.5),
    );
  }
}
