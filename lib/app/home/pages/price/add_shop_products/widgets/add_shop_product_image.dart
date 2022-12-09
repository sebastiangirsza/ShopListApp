import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductGroup extends StatelessWidget {
  const AddProductGroup({
    required this.onProductGroupChanged,
    required this.chosenGroup,
    Key? key,
  }) : super(key: key);

  final Function(String?) onProductGroupChanged;
  final String? chosenGroup;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            label: Text(
                style: GoogleFonts.getFont('Saira',
                    fontSize: 12, color: Colors.black),
                'Kategoria produktu'),
            border: InputBorder.none,
          ),
          borderRadius: BorderRadius.circular(10),
          iconDisabledColor: Colors.black,
          iconEnabledColor: Colors.black,
          dropdownColor: Colors.white,
          isExpanded: true,
          value: chosenGroup,
          onChanged: onProductGroupChanged,
          items: <String>[
            'Warzywa',
            'Owoce',
            'Mięso',
            'Pieczywo',
            'Suche produkty',
            'Nabiał',
            'Chemia',
            'Przekąski',
            'Napoje',
            'Mrożonki',
            'Dania gotowe',
            'Sosy',
            'Inne',
          ].map<DropdownMenuItem<String>>(
            (productGroup) {
              return DropdownMenuItem<String>(
                value: productGroup,
                child: Center(
                  child: Text(
                    productGroup,
                    style: GoogleFonts.getFont(
                      'Saira',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
