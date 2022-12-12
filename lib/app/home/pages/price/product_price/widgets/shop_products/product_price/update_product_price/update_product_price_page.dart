import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/widgets/Update_product_price.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/widgets/update_product_button.dart';

class UpdateProductPricePage extends StatefulWidget {
  const UpdateProductPricePage({
    required this.productPriceId,
    Key? key,
  }) : super(key: key);

  final String productPriceId;
  @override
  State<UpdateProductPricePage> createState() => _UpdateProductPricePageState();
}

class _UpdateProductPricePageState extends State<UpdateProductPricePage> {
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
                    UpdateProductPrice(
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
                          child: UpdateProductButton(
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
