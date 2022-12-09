import 'package:cloud_firestore/cloud_firestore.dart';

class ShopProductsModel {
  final String shopProductName;
  final String productGroup;
  final String id;

  ShopProductsModel({
    required this.shopProductName,
    required this.productGroup,
    required this.id,
  });

  ShopProductsModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> shopProducts)
      : shopProductName = shopProducts['shop_product_name'],
        productGroup = shopProducts['product_group'],
        id = shopProducts.id;
}
