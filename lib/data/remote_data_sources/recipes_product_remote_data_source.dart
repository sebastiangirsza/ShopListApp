import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipesProductRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecipesProductsStream(
      String searchKey) {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .where('product_name', isGreaterThanOrEqualTo: searchKey)
        .where('product_name', isLessThan: '${searchKey}z')
        .snapshots();
  }
}
