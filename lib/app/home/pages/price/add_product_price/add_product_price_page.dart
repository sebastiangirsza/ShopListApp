import 'package:flutter/material.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/add_product_button.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/add_product_price.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';

class AddProductPricePage extends StatefulWidget {
  const AddProductPricePage({
    required this.shopName,
    required this.shopProductModel,
    required this.productPriceId,
    Key? key,
  }) : super(key: key);

  final ShopProductsModel shopProductModel;
  final String shopName;
  final String productPriceId;
  @override
  State<AddProductPricePage> createState() => _AddProductPricePageState();
}

class _AddProductPricePageState extends State<AddProductPricePage> {
  // late String? productName;
  late double? productPrice;
  // late String? shopName;
  // late String? downloadURL;
  // late String? shopDownloadURL;
  // dynamic chosenShop;

  @override
  void initState() {
    // productName = 'productName';
    productPrice = 0.0;
    // shopName = 'shopName';
    // downloadURL = 'downloadURL';
    // shopDownloadURL = 'shopDownloadURL';
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
                    // ChooseShop(
                    //   onShopChanged: (newShop) {
                    //     setState(() {
                    //       chosenShop = newShop;
                    //       shopName = newShop.shopName.toString();
                    //       shopDownloadURL = newShop.downloadURL.toString();
                    //     });
                    //   },
                    //   chosenShop: chosenShop,
                    // ),
                    AddProductPrice(
                      onProductPriceChanged: (newProductPrice) {
                        setState(() {
                          productPrice = double.tryParse(newProductPrice);
                        });
                      },
                    ),
                    AddProductButton(
                      shopName: widget.shopName,
                      productName: widget.shopProductModel.shopProductName,
                      productPrice: productPrice!,
                      date: DateTime.now(),
                      id: widget.productPriceId,
                      // downloadURL: widget.shopProductModel.downloadURL,
                      // shopDownloadURL: shopDownloadURL!,
                    ),
                  ],
                ),
              ),
            ));
  }
}
