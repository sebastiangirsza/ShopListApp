import 'package:cloud_firestore/cloud_firestore.dart';

class ShopProductsModel {
  final String shopProductName;
  final String downloadURL;
  final String id;

  ShopProductsModel({
    required this.shopProductName,
    required this.downloadURL,
    required this.id,
  });

  ShopProductsModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> shopProducts)
      : shopProductName = shopProducts['shop_product_name'],
        downloadURL = shopProducts['download_url'],
        id = shopProducts.id;
}
