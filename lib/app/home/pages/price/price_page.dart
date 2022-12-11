import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/product_price_page.dart';
import 'package:shoplistapp/app/home/pages/price/shops/shop_page.dart';

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
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                blurRadius: 2,
                offset: Offset(3, 3),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: ExpansionTile(
            title: Text(
              'Lista sklepów',
              style: GoogleFonts.getFont('Saira',
                  fontSize: 21,
                  color: const Color.fromARGB(255, 0, 63, 114),
                  fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(
              Icons.shopping_cart,
              color: Color.fromARGB(255, 0, 63, 114),
            ),
            children: const [
              ShopPage(),
            ],
          ),
        ),
        const ProductPricePage(),
      ],
    );
  }
}
