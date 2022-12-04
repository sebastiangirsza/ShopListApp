import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/add_product_price_page.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/cubit/product_price_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/shops/cubit/shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';

@injectable
class ProductsPrice extends StatelessWidget {
  const ProductsPrice({
    Key? key,
    required this.shopProductModel,
  }) : super(key: key);

  final ShopProductsModel shopProductModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopCubit>()..start(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          final shopsModels = state.shops;

          List<dynamic> shopsList = shopsModels;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: shopsList.length,
            itemBuilder: (context, index) {
              return Container(
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
                  color: Colors.blue,
                ),
                child: Row(
                  // shrinkWrap: true,
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
                            shopsList[index].downloadURL,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: BlocProvider(
                        create: (context) => getIt<ProductPriceCubit>()
                          ..getProductPriceStream(
                              shopProductModel.shopProductName,
                              shopsList[index].shopName),
                        child:
                            BlocBuilder<ProductPriceCubit, ProductPriceState>(
                          builder: (context, state) {
                            final productPriceModels = state.productsPrice;

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: productPriceModels.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productPriceModels[index]
                                            .productPrice
                                            .toString(),
                                        style: GoogleFonts.getFont(
                                          'Saira',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return AddProductPricePage(
                                              shopName:
                                                  shopsList[index].shopName,
                                              shopProductModel:
                                                  shopProductModel,
                                              productPriceId:
                                                  productPriceModels[index].id,
                                            );
                                          }),
                                        );
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    // BlocProvider(
                    //   create: (context) => getIt<AddProductPriceCubit>(),
                    //   child: BlocBuilder<AddProductPriceCubit,
                    //       AddProductPriceState>(
                    //     builder: (context, state) {
                    //       return
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
