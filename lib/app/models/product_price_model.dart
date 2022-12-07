import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPriceModel {
  final String shopProductName;
  final double productPrice;
  final String shopDownloadURL;
  // final DateTime date;
  // final String downloadURL;
  // final String shopDownloadURL;
  final String id;

  ProductPriceModel({
    required this.shopProductName,
    required this.productPrice,
    required this.shopDownloadURL,
    // required this.date,
    // required this.downloadURL,
    // required this.shopDownloadURL,
    required this.id,
  });

  ProductPriceModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> productPrice)
      : shopProductName = productPrice['shop_product_name'],
        productPrice = productPrice['product_price'],
        shopDownloadURL = productPrice['shop_download_url'],
        // date = productPrice['date'].toDate(),
        // downloadURL = productPrice['download_url'],
        // shopDownloadURL = productPrice['shop_download_url'],
        id = productPrice.id;
}
