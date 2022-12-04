import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/shops/cubit/shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class ChooseShop extends StatelessWidget {
  const ChooseShop({
    required this.onShopChanged,
    required this.chosenShop,
    Key? key,
  }) : super(key: key);

  final Function(dynamic) onShopChanged;
  final dynamic chosenShop;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopCubit>()..start(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          final shopModels = state.shops;
          List<DropdownMenuItem> shopsList = [];
          for (final shopModel in shopModels) {
            shopsList.add(
              DropdownMenuItem(
                value: shopModel,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            shopModel.downloadURL,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      shopModel.shopName,
                      style: GoogleFonts.getFont(
                        'Saira',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
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
                color: Colors.white),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                    style: GoogleFonts.getFont(
                      'Saira',
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    'Wybierz sklep'),
                borderRadius: BorderRadius.circular(10),
                iconDisabledColor: Colors.black,
                iconEnabledColor: Colors.black,
                dropdownColor: Colors.white,
                isExpanded: true,
                items: shopsList,
                onChanged: onShopChanged,
                value: chosenShop,
              ),
            ),
          );
        },
      ),
    );
  }
}
