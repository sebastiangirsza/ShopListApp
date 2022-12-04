import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/product_price.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/cubit/shop_products_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

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
                  margin: const EdgeInsets.all(10),
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
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(3, 3),
                                )
                              ],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  shopProductModel.downloadURL,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  shopProductModel.shopProductName,
                                  style: GoogleFonts.getFont(
                                    'Saira',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                // TextButton(
                                //   onPressed: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (_) => AddProductPricePage(
                                //           shopName: ,
                                //           shopProductModel: shopProductModel,
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: const Text(
                                //     'Dodaj cenę',
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ProductsPrice(
                        shopProductModel: shopProductModel,
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
