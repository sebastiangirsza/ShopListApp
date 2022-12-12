import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddShopName extends StatelessWidget {
  const AddShopName({
    Key? key,
    required this.onNameChanged,
  }) : super(key: key);

  final Function(String) onNameChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: TextField(
        style: GoogleFonts.getFont(
          'Saira',
          fontSize: 12,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: GoogleFonts.getFont(
            'Saira',
            fontSize: 12,
            color: Colors.black,
          ),
          label: const Text(
            'Nazwa sklepu',
          ),
        ),
        onChanged: onNameChanged,
        textAlign: TextAlign.center,
      ),
    );
  }
}
