import 'package:cloud_firestore/cloud_firestore.dart';

class ProductPriceModel {
  final String productName;
  final double productPrice;
  final String shopName;
  final String downloadURL;
  final String id;

  ProductPriceModel({
    required this.productName,
    required this.productPrice,
    required this.shopName,
    required this.downloadURL,
    required this.id,
  });

  ProductPriceModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> productPrice)
      : productName = productPrice['product_name'],
        productPrice = productPrice['product_price'],
        shopName = productPrice['shop_name'],
        downloadURL = productPrice['download_url'],
        id = productPrice.id;
}
