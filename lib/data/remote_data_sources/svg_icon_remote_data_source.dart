import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class SvgIconRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getSvgIconStream() {
    return FirebaseFirestore.instance
        .collection('categories_icons')
        .snapshots();
  }
}
