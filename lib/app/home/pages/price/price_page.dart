import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/add_shop_products_page.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/product_price_page.dart';
import 'package:shoplistapp/app/home/pages/price/shop/shop_page.dart';

@injectable
class PricePage extends StatelessWidget {
  const PricePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          constraints: const BoxConstraints(maxHeight: double.infinity),
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.black,
          ),
          child: ExpansionTile(
            title: Expanded(
                child: Text(
              'Lista sklepów',
              style: GoogleFonts.getFont('Saira',
                  fontSize: 21,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )),
            trailing: const Icon(
              Icons.shopping_cart,
              color: Colors.blue,
            ),
            children: const [
              ShopPage(),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProductPricePage(),
                fullscreenDialog: true,
              ),
            );
          },
          child: const Text('Produkty'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddShopProductsPage(),
                fullscreenDialog: true,
              ),
            );
          },
          child: const Text('Dodaj produkt'),
        ),
      ],
    );
  }
}
