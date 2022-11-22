import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecipesProductRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecipesProductsStream(
      String searchKey) {
    final userID = FirebaseAuth.instance.currentUser?.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('purchased_products')
        .where('lista_procura',
            arrayContains: searchKey.toLowerCase()) // search with first letter
        .snapshots();
  }
}
