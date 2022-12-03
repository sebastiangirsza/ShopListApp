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

  Future<void> addProductPrice(
    String productName,
    double productPrice,
    String shopName,
    String downloadURL,
    String shopDownloadURL,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('product_price')
        .add({
      'product_name': productName,
      'product_price': productPrice,
      'shop_name': shopName,
      'download_url': downloadURL,
      'shop_download_url': shopDownloadURL,
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
