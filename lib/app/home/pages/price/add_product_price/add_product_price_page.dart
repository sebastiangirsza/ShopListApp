import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/add_product_button.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/add_product_price.dart';

class AddProductPricePage extends StatefulWidget {
  const AddProductPricePage({
    required this.productPriceId,
    Key? key,
  }) : super(key: key);

  final String productPriceId;
  @override
  State<AddProductPricePage> createState() => _AddProductPricePageState();
}

class _AddProductPricePageState extends State<AddProductPricePage> {
  late double? productPrice;

  @override
  void initState() {
    productPrice = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: const Color.fromARGB(255, 200, 233, 255),
              content: Container(
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    AddProductPrice(
                      onProductPriceChanged: (newProductPrice) {
                        setState(() {
                          productPrice = double.tryParse(newProductPrice);
                        });
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Anuluj',
                                style: GoogleFonts.getFont(
                                  'Saira',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AddProductButton(
                            productPrice: productPrice!,
                            id: widget.productPriceId,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
