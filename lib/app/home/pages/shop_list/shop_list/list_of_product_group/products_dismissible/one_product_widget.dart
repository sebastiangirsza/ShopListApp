import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product/add_to_storage_alert_dialog_widget.dart';
import 'package:shoplistapp/app/models/product_model.dart';

class OneProductWidget extends StatelessWidget {
  const OneProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (productModel.isChecked == false)
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
                productModel.productName,
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
                  productModel.productQuantity.toString(),
                  style: GoogleFonts.getFont(
                    'Saira',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    (productModel.isChecked == true)
                        ? showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AddToStorageAlertDialogWidget(
                                  productModel: productModel);
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
