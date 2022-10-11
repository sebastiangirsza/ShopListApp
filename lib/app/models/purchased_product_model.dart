import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PurchasedProductModel {
  final String id;
  final String purchasedProductGroup;
  final String purchasedProductName;

  final DateTime purchasedProductDate;
  final String storageName;
  final bool isDated;
  final List listaProcura;

  PurchasedProductModel(
      {required this.id,
      required this.purchasedProductGroup,
      required this.purchasedProductName,
      required this.purchasedProductDate,
      required this.storageName,
      required this.isDated,
      required this.listaProcura});

  PurchasedProductModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> purchasedProducts)
      : purchasedProductGroup = purchasedProducts['product_group'],
        purchasedProductName = purchasedProducts['product_name'],
        purchasedProductDate = (purchasedProducts['product_date']).toDate(),
        id = purchasedProducts.id,
        storageName = (purchasedProducts['storage_name']),
        isDated = purchasedProducts['is_dated'],
        listaProcura = purchasedProducts['lista_procura'];

  String dateFormatted() {
    return DateFormat('dd/MM/yyyy').format(purchasedProductDate);
  }
}
