import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/add_product_price_page.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop/add_shop_page.dart';
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
                  builder: (context) => const AddProductPricePage(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: const Text('Dodaj produkt')),
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
      ],
    );
  }
}

// class ListViewItem extends StatelessWidget {
//   const ListViewItem({
//     Key? key,
//     required this.itemModel,
//   }) : super(key: key);

//   final ItemModel itemModel;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (context) => DetailsPage(id: itemModel.id),
//         //   ),
//         // );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 10,
//           horizontal: 30,
//         ),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.black12,
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: Colors.black12,
//                   image: DecorationImage(
//                     image: NetworkImage(
//                       itemModel.imageURL,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.all(10),
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             itemModel.title,
//                             style: const TextStyle(
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             itemModel.releaseDateFormatted(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white70,
//                     ),
//                     margin: const EdgeInsets.all(10),
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       children: [
//                         Text(
//                           itemModel.daysLeft(),
//                           style: const TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Text('days left'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
