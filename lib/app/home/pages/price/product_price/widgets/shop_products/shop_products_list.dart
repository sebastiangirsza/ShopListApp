import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/product_price.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/cubit/shop_products_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/cubit/svg_icon_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';

@injectable
class ShopProductsList extends StatelessWidget {
  const ShopProductsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopProductsCubit>()..start(),
      child: BlocBuilder<ShopProductsCubit, ShopProductsState>(
        builder: (context, state) {
          final shopProductsModels = state.shopProducts;
          return ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (final shopProductModel in shopProductsModels) ...[
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: const BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 2,
                        offset: Offset(3, 3),
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 35,
                                height: 25,
                                child: SvgIcon(
                                    productGroup:
                                        shopProductModel.productGroup)),
                            /////////////////////////////////////////
                            // Text(
                            //   shopProductModel.productGroup,
                            //   style: GoogleFonts.getFont(
                            //     'Saira',
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.bold,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            /////////////////////////////////////////
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      shopProductModel.shopProductName,
                                      style: GoogleFonts.getFont(
                                        'Saira',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 200, 233, 255),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return ProductsPrice(
                                              shopProductModel:
                                                  shopProductModel,
                                            );
                                          }));
                                    },
                                    child: Text(
                                      'Pokaż ceny',
                                      style: GoogleFonts.getFont(
                                        'Saira',
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    Key? key,
    required this.productGroup,
  }) : super(key: key);

  final String productGroup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SvgIconCubit>()..start(productGroup),
      child: BlocBuilder<SvgIconCubit, SvgIconState>(
        builder: (context, state) {
          final svgIconModels = state.svgIcons;
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final svgIconModel in svgIconModels) ...[
                SizedBox(
                  width: 35,
                  height: 25,
                  child: SvgPicture.asset(
                    svgIconModel.svgIcon,
                    color: const Color.fromARGB(255, 0, 63, 114),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}

// @injectable
// class SvgIcon extends StatelessWidget {
//   const SvgIcon({
//     required this.shopProductModel,
//     Key? key,
//   }) : super(key: key);
//   final ShopProductsModel shopProductModel;

//   @override
//   Widget build(BuildContext context) {
//     // final String group = shopProductModel.productGroup;
//     return 
//   }
// }


  // final String vegetable = 'images/icons/vegetable_icon.svg';
  // final String fruits = 'images/icons/fruits_icon.svg';
  // final String meat = 'images/icons/meat_icon.svg';
  // final String bread = 'images/icons/bread_icon.svg';
  // final String dryProducts = 'images/icons/dry_products_icon.svg';
  // final String dairy = 'images/icons/dairy_icon.svg';
  // final String chemistry = 'images/icons/chemistry_icon.svg';
  // final String snacks = 'images/icons/snacks_icon.svg';
  // final String drinks = 'images/icons/drinks_icon.svg';
  // final String frosty = 'images/icons/frosty_icon.svg';
  // final String pizza = 'images/icons/pizza_icon.svg';
  // final String sauce = 'images/icons/sauce_icon.svg';
  // final String other = 'images/icons/other_icon.svg';


//   (group == 'Warzywa')
          // ? vegetable
          // : (group == 'Owoce')
          //     ? fruits
          //     : (group == 'Mięso')
          //         ? meat
          //         : (group == 'Pieczywo')
          //             ? bread
          //             : (group == 'Suche produkty')
          //                 ? dryProducts
          //                 : (group == 'Nabiał')
          //                     ? dairy
          //                     : (group == 'Chemia')
          //                         ? chemistry
          //                         : (group == 'Przekąski')
          //                             ? snacks
          //                             : (group == 'Napoje')
          //                                 ? drinks
          //                                 : (group == 'Mrożonki')
          //                                     ? frosty
          //                                     : (group == 'Dania gotowe')
          //                                         ? pizza
          //                                         : (group == 'Sosy')
          //                                             ? sauce
          //                                             : other,
