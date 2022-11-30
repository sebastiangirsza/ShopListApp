import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/add_product_price_page.dart';
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 200, 233, 255),
            Color.fromARGB(255, 213, 238, 255),
            Color.fromARGB(255, 228, 244, 255),
            Color.fromARGB(255, 244, 250, 255),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 200, 233, 255),
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 7.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 10,
          scrolledUnderElevation: 10,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          title: Text(
            'Lista sklepów z produktami',
            style: GoogleFonts.getFont(
              'Saira',
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 200, 233, 255),
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 7.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
          actions: const [],
        ),
        body: BlocProvider(
          create: (context) => getIt<ShopProductsCubit>()..start(),
          child: BlocBuilder<ShopProductsCubit, ShopProductsState>(
            builder: (context, state) {
              final shopProductsModels = state.shopProducts;
              return ListView(
                shrinkWrap: true,
                children: [
                  for (final shopProductModel in shopProductsModels)
                    BlocProvider(
                      create: (context) => getIt<ProductPriceCubit>()
                        ..getProductPriceStream(
                            shopProductModel.shopProductName),
                      child: BlocBuilder<ProductPriceCubit, ProductPriceState>(
                        builder: (context, state) {
                          final productsPriceModels = state.productsPrice;
                          return Container(
                            margin: const EdgeInsets.all(10),
                            color: Colors.blue,
                            child: ListView(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => AddProductPricePage(
                                          shopProductModel: shopProductModel,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            boxShadow: const <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 15)
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  shopProductModel.downloadURL,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                        shopProductModel.shopProductName,
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                for (final productsPriceModel
                                    in productsPriceModels) ...[
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    color: Colors.white70,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              boxShadow: const <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.black,
                                                    blurRadius: 15)
                                              ],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    productsPriceModel
                                                        .shopDownloadURL,
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Text(productsPriceModel.productPrice
                                            .toString()),
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
        ),
      ),
    );
  }
}
