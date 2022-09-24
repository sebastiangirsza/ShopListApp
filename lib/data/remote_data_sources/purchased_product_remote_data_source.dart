import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoplistappsm/app/models/purchased_product_model.dart';

class PurchasedProductsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchasedProductsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .snapshots();
  }

  Future<void> addYourProduct(
    String purchasedProductGroup,
    String purchasedProductName,
    int purchasedProductQuantity,
    String storageName,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .add({
      'product_group': purchasedProductGroup,
      'product_name': purchasedProductName,
      'product_quantity': purchasedProductQuantity,
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
