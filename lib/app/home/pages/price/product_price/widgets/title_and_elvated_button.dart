import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/add_shop_products_page.dart';

class TitleAndElevatedButton extends StatelessWidget {
  const TitleAndElevatedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lista produktów',
            style: GoogleFonts.getFont(
              'Saira',
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: const Color.fromARGB(255, 0, 63, 114),
              shadows: <Shadow>[
                const Shadow(
                  blurRadius: 7.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddShopProductsPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Color.fromARGB(255, 0, 63, 114),
                ),
                child: Column(
                  children: [
                    Text(
                      'Dodaj',
                      style: GoogleFonts.getFont(
                        'Saira',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'produkt',
                      style: GoogleFonts.getFont(
                        'Saira',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
