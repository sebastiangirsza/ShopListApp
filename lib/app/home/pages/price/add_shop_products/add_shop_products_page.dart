import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/widgets/add_shop_product_button.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/widgets/add_shop_product_name.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/widgets/add_shop_product_image.dart';

class AddShopProductsPage extends StatefulWidget {
  const AddShopProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddShopProductsPage> createState() => _AddShopProductsPageState();
}

class _AddShopProductsPageState extends State<AddShopProductsPage> {
  late String? shopProductName;
  late String? productGroup;
  String? chosenGroup;

  @override
  void initState() {
    shopProductName = 'shopProductName';
    productGroup = 'sztuka';
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
            'Dodaj product',
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
            const SizedBox(height: 10),
            AddShopName(
              onNameChanged: (newShopProductName) {
                setState(() {
                  shopProductName = newShopProductName;
                });
              },
            ),
            AddProductGroup(
              onProductGroupChanged: (newProductGroup) {
                setState(() {
                  productGroup = newProductGroup;
                });
              },
              chosenGroup: chosenGroup,
            ),
            AddShopButton(
                shopProductName: shopProductName!, productGroup: productGroup!),
          ],
        ),
      ),
    );
  }
}
