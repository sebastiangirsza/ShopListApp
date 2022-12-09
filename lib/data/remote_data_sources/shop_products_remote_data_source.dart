import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShopProductsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getShopProductsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('shop_products')
        .orderBy('shop_product_name', descending: false)
        .snapshots();
  }

  Future<void> addShopProduct(
    String shopProductName,
    String productGroup,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('shop_products')
        .add({
      'shop_product_name': shopProductName,
      'product_group': productGroup,
    });
  }

  // Future<void> delete({required String id}) {
  //   final userID = FirebaseAuth.instance.currentUser?.uid;
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userID)
  //       .collection('recipes')
  //       .doc(id)
  //       .delete();
  // }
}
