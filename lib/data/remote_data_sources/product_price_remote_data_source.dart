import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductPriceRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getProductPriceStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('product_price')
        .orderBy('product_price', descending: false)
        .snapshots();
  }

  Future<void> updateProductPrice(
    double productPrice,
    String id,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('product_price')
        .doc(id)
        .update({
      'product_price': productPrice,
    });
  }

  Future<void> addFirstProductPrice(
    String shopProductName,
    double productPrice,
    String shopDownloadURL,
    String shopName,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('product_price')
        .add({
      'shop_product_name': shopProductName,
      'product_price': productPrice,
      'shop_download_url': shopDownloadURL,
      'shop_name': shopName,
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
