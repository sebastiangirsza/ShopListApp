import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/add_product_button.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/add_product_price.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/widgets/choose_shop.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';

class AddProductPricePage extends StatefulWidget {
  const AddProductPricePage({
    required this.shopProductModel,
    Key? key,
  }) : super(key: key);

  final ShopProductsModel shopProductModel;
  @override
  State<AddProductPricePage> createState() => _AddProductPricePageState();
}

class _AddProductPricePageState extends State<AddProductPricePage> {
  late String? productName;
  late double? productPrice;
  late String? shopName;
  late String? downloadURL;
  late String? shopDownloadURL;
  dynamic chosenShop;

  @override
  void initState() {
    productName = 'productName';
    productPrice = 0.0;
    shopName = 'shopName';
    downloadURL = 'downloadURL';
    shopDownloadURL = 'shopDownloadURL';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 200, 233, 255),
            Color.fromARGB(255, 213, 238, 255),
            Color.fromARGB(255, 228, 244, 255),
            Color.fromARGB(255, 244, 250, 255),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 200, 233, 255),
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 7.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 10,
          scrolledUnderElevation: 10,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          title: Text(
            'Dodaj produkt',
            style: GoogleFonts.getFont(
              'Saira',
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 200, 233, 255),
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 7.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
          actions: const [],
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            ChooseShop(
              onShopChanged: (newShop) {
                setState(() {
                  chosenShop = newShop;
                  shopName = newShop.shopName.toString();
                  shopDownloadURL = newShop.downloadURL.toString();
                });
              },
              chosenShop: chosenShop,
            ),
            AddProductPrice(
              onProductPriceChanged: (newProductPrice) {
                setState(() {
                  productPrice = double.tryParse(newProductPrice);
                });
              },
            ),
            AddProductButton(
              shopName: shopName!,
              productName: widget.shopProductModel.shopProductName,
              productPrice: productPrice!,
              downloadURL: widget.shopProductModel.downloadURL,
              shopDownloadURL: shopDownloadURL!,
            ),
          ],
        ),
      ),
    );
  }
}
