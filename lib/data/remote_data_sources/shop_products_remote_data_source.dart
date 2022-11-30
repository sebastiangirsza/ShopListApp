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
        .snapshots();
  }

  Future<void> addShopProduct(
    String shopProductName,
    String downloadURL,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('shop_products')
        .add({
      'shop_product_name': shopProductName,
      'download_url': downloadURL,
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
