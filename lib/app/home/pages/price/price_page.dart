import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop/add_shop_page.dart';
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
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddShopPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('Dodaj sklep')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ShopPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('Sklepy')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProductPricePage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('Produkty')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddShopProductsPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('Dodaj produkt')),
      ],
    );
  }
}
