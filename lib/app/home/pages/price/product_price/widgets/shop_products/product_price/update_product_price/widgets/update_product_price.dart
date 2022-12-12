import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProductPrice extends StatelessWidget {
  const UpdateProductPrice({
    Key? key,
    required this.onProductPriceChanged,
  }) : super(key: key);

  final Function(String) onProductPriceChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Center(
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
              'Cena',
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d+\.?\d{0,2}'),
            )
          ],
          onChanged: onProductPriceChanged,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
