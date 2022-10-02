import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getProductsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .snapshots();
  }

  Future<void> add(
    String productGroup,
    String productName,
    int productQuantity,
    bool isChecked,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .add({
      'product_group': productGroup,
      'product_name': productName,
      'product_quantity': productQuantity,
      'product_check': isChecked,
    });
  }

  Future<void> isChecked(
    bool isChecked,
    String id,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .doc(id)
        .update({
      'product_check': isChecked,
    });
  }

  Future<void> delete({required String id}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('products')
        .doc(id)
        .delete();
  }
}
