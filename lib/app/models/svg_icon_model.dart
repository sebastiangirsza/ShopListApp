import 'package:cloud_firestore/cloud_firestore.dart';

class SvgIconModel {
  final String svgIcon;
  final String productGroup;
  final String id;

  SvgIconModel({
    required this.svgIcon,
    required this.productGroup,
    required this.id,
  });

  SvgIconModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> svgIcons)
      : svgIcon = svgIcons['svg_icon'],
        productGroup = svgIcons['product_group'],
        id = svgIcons.id;
}
