import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShopRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getShopsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('shops')
        .snapshots();
  }

  Future<void> addShop(
    String shopName,
    String downloadURL,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('shops')
        .add({
      'shop_name': shopName,
      'download_url': downloadURL,
    });
  }

  Future<void> addPriceToNewShop(
    String shopProductName,
    double productPrice,
    String shopDownloadURL,
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
