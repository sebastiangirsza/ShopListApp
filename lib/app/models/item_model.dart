import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.imageURL,
    required this.releaseDate,
  });
  final String id;
  final String title;
  final String imageURL;
  final DateTime releaseDate;

  ItemModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageURL = json['image_url'],
        releaseDate = json['release_date'].toDate();

  String daysLeft() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String releaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}
