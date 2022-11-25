import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  final String shopName;
  final String downloadURL;
  final String id;

  ShopModel({
    required this.shopName,
    required this.downloadURL,
    required this.id,
  });

  ShopModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> shops)
      : shopName = shops['shop_name'],
        downloadURL = shops['download_url'],
        id = shops.id;
}
