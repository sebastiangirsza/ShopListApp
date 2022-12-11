import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoplistapp/app/models/svg_icon_model.dart';

class ShopProductsModel {
  final String shopProductName;
  final String productGroup;
  final String svgIcon;
  final String id;

  ShopProductsModel({
    required this.shopProductName,
    required this.productGroup,
    required this.svgIcon,
    required this.id,
  });

  ShopProductsModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> shopProducts)
      : shopProductName = shopProducts['shop_product_name'],
        productGroup = shopProducts['product_group'],
        svgIcon = shopProducts['svg_icon'],
        id = shopProducts.id;

  ShopProductsModel copyWith({required String svgIcon}) => ShopProductsModel(
      shopProductName: shopProductName,
      productGroup: productGroup,
      svgIcon: svgIcon,
      id: id);
}
