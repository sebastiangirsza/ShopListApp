import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductFromList extends StatelessWidget {
  const AddProductFromList({
    required this.productGroup,
    required this.onNameChanged,
    required this.shopProduct,
    required this.shopProductList,
    Key? key,
  }) : super(key: key);
  final String productGroup;
  final Function(dynamic) onNameChanged;

  final dynamic shopProduct;
  final List shopProductList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: boxDecoration(),
      child: (shopProductList.isEmpty)
          ? Center(
              child: Text(
                'Brak na liście produktów z tej kategorii',
                style: GoogleFonts.getFont(
                  'Saira',
                  fontSize: 9,
                  color: Colors.black,
                ),
              ),
            )
          : DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  iconDisabledColor: Colors.black,
                  iconEnabledColor: Colors.black,
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: shopProduct,
                  onChanged: onNameChanged,
                  items: shopProductList.map<DropdownMenuItem>(
                    (shopProduct) {
                      return DropdownMenuItem(
                        value: shopProduct,
                        child: Center(
                          child: Text(
                            shopProduct.shopProductName,
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
            ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: (shopProductList.isEmpty)
          ? Colors.grey
          : Colors.white.withOpacity(0.5),
    );
  }
}
