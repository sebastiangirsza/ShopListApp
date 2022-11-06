import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String productGroup;
  final String productName;
  final int productQuantity;
  final bool isChecked;
  final String productTypeName;
  final int quantityGram;

  ProductModel({
    required this.id,
    required this.productGroup,
    required this.productName,
    required this.productQuantity,
    required this.isChecked,
    required this.productTypeName,
    required this.quantityGram,
  });

  ProductModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> products)
      : productGroup = products['product_group'],
        productName = products['product_name'],
        productQuantity = products['product_quantity'],
        id = products.id,
        isChecked = products['product_check'],
        productTypeName = products['product_type_name'],
        quantityGram = products['quantity_gram'];
}
