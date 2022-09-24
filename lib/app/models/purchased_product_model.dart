import 'package:cloud_firestore/cloud_firestore.dart';

class PurchasedProductModel {
  final String id;
  final String purchasedProductGroup;
  final String purchasedProductName;
  final int purchasedProductQuantity;
  final String storageName;

  PurchasedProductModel({
    required this.id,
    required this.purchasedProductGroup,
    required this.purchasedProductName,
    required this.purchasedProductQuantity,
    required this.storageName,
  });

  PurchasedProductModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> purchasedProducts)
      : purchasedProductGroup = purchasedProducts['product_group'],
        purchasedProductName = purchasedProducts['product_name'],
        purchasedProductQuantity = (purchasedProducts['product_quantity']),
        id = purchasedProducts.id,
        storageName = (purchasedProducts['storage_name']);
}
