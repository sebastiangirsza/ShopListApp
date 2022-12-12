import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/product_price/cubit/product_price_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/update_product_price_page.dart';
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
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        backgroundColor: const Color.fromARGB(255, 200, 233, 255),
        content: ListView(
          shrinkWrap: true,
          children: [
            BlocProvider(
              create: (context) => getIt<ProductPriceCubit>()
                ..getProductPriceStream(
                  shopProductModel.shopProductName,
                ),
              child: BlocBuilder<ProductPriceCubit, ProductPriceState>(
                builder: (context, state) {
                  final productPriceModels = state.productsPrice;

                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: productPriceModels.length,
                              itemBuilder: (context, index) {
                                final first = productPriceModels[0]
                                    .productPrice
                                    .toString();
                                final Color color = index == 0 ||
                                        first ==
                                            productPriceModels[index]
                                                .productPrice
                                                .toString()
                                    ? (productPriceModels[index]
                                                .productPrice
                                                .toString() ==
                                            '999999999999999.0')
                                        ? Colors.blue
                                        : Colors.green
                                    : Colors.blue;
                                return Container(
                                  margin: const EdgeInsets.all(5),
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
                                    color: color,
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
                                              productPriceModels[index]
                                                  .shopDownloadURL,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          (productPriceModels[index]
                                                      .productPrice
                                                      .toString() !=
                                                  '999999999999999.0')
                                              ? productPriceModels[index]
                                                  .productPrice
                                                  .toString()
                                              : 'Dodaj cenę',
                                          style: GoogleFonts.getFont(
                                            'Saira',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          height: 30,
                                          width: 30,
                                          child: IconButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return UpdateProductPricePage(
                                                    productPriceId:
                                                        productPriceModels[
                                                                index]
                                                            .id,
                                                  );
                                                }),
                                              );
                                            },
                                            icon: Icon(
                                              (productPriceModels[index]
                                                          .productPrice
                                                          .toString() !=
                                                      '999999999999999.0')
                                                  ? Icons.edit
                                                  : Icons.add,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Zamknij',
                    style: GoogleFonts.getFont('Saira',
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
