import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPriceModel {
  final String productName;
  final double productPrice;
  final String shopName;
  // final DateTime date;
  // final String downloadURL;
  // final String shopDownloadURL;
  final String id;

  ProductPriceModel({
    required this.productName,
    required this.productPrice,
    required this.shopName,
    // required this.date,
    // required this.downloadURL,
    // required this.shopDownloadURL,
    required this.id,
  });

  ProductPriceModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> productPrice)
      : productName = productPrice['product_name'],
        productPrice = productPrice['product_price'],
        shopName = productPrice['shop_name'],
        // date = productPrice['date'].toDate(),
        // downloadURL = productPrice['download_url'],
        // shopDownloadURL = productPrice['shop_download_url'],
        id = productPrice.id;
}
