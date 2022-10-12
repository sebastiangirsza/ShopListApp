import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PurchasedProductsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchasedProductsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .orderBy('product_date', descending: false)
        .snapshots();
  }

  Future<void> addYourProduct(
    String purchasedProductGroup,
    String purchasedProductName,
    DateTime purchasedProductDate,
    String storageName,
    bool isDated,
    List listaProcura,
    String productTypeName,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .add({
      'product_group': purchasedProductGroup,
      'product_name': purchasedProductName,
      'product_date': purchasedProductDate,
      'storage_name': storageName,
      'is_dated': isDated,
      'lista_procura': listaProcura,
      'product_type_name': productTypeName,
    });
  }

  Future<void> isDated(
    bool isDated,
    String id,
    DateTime purchasedProductDate,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .doc(id)
        .update({
      'is_dated': isDated,
      'product_date': purchasedProductDate,
    });
  }

  Future<void> updateStorage(
    String storageName,
    String id,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .doc(id)
        .update({
      'storage_name': storageName,
    });
  }

  Future<void> deletePurchasedProduct({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .doc(id)
        .delete();
  }
}
