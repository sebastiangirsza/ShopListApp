import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/add_product_price_page.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/add_shop_products_page.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/cubit/product_price_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/shop_products/cubit/shop_products_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class ProductPricePage extends StatelessWidget {
  const ProductPricePage({
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lista produktów',
                      style: GoogleFonts.getFont(
                        'Saira',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: const Color.fromARGB(255, 0, 63, 114),
                        shadows: <Shadow>[
                          const Shadow(
                            blurRadius: 7.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddShopProductsPage(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            color: Color.fromARGB(255, 0, 63, 114),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Dodaj',
                                style: GoogleFonts.getFont('Saira',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                'produkt',
                                style: GoogleFonts.getFont('Saira',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              for (final shopProductModel in shopProductsModels)
                BlocProvider(
                  create: (context) => getIt<ProductPriceCubit>()
                    ..getProductPriceStream(shopProductModel.shopProductName),
                  child: BlocBuilder<ProductPriceCubit, ProductPriceState>(
                    builder: (context, state) {
                      final productsPriceModels = state.productsPrice;
                      return Container(
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
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
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
                                          fit: BoxFit.cover)),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        shopProductModel.shopProductName,
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    AddProductPricePage(
                                                  shopProductModel:
                                                      shopProductModel,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Dodaj cenę')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            for (final productsPriceModel
                                in productsPriceModels) ...[
                              Container(
                                margin: const EdgeInsets.all(5),
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
                                  color: Color.fromARGB(255, 200, 233, 255),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      height: 30,
                                      width: 45,
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
                                                productsPriceModel
                                                    .shopDownloadURL,
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cena:',
                                          style: GoogleFonts.getFont('Saira',
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          productsPriceModel.productPrice
                                              .toString(),
                                          style: GoogleFonts.getFont('Saira',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
