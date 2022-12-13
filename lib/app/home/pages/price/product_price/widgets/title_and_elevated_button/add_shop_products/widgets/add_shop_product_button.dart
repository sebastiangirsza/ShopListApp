import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/cubit/shop_products_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/title_and_elevated_button/add_shop_products/cubit/add_shop_product_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/shops/cubit/shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddShopProductButton extends StatelessWidget {
  const AddShopProductButton({
    required this.shopProductName,
    required this.productGroup,
    Key? key,
  }) : super(key: key);

  final String shopProductName;
  final String productGroup;
  final String svgIcon = 'svgIcon';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopProductsCubit>()..start(),
      child: BlocBuilder<ShopProductsCubit, ShopProductsState>(
        builder: (context, state) {
          final shopProductModels = state.shopProducts;
          List<String> productList = [];
          for (var shopProductModel in shopProductModels) {
            productList.add(shopProductModel.shopProductName.toLowerCase());
          }
          return BlocProvider(
            create: (context) => getIt<ShopCubit>()..start(),
            child: BlocBuilder<ShopCubit, ShopState>(
              builder: (context, state) {
                final shopsModels = state.shops;
                return BlocProvider(
                  create: (context) => getIt<AddShopProductsCubit>(),
                  child:
                      BlocListener<AddShopProductsCubit, AddShopProductsState>(
                    listener: (context, state) {
                      for (final shopsModel in shopsModels) {
                        context
                            .read<AddShopProductsCubit>()
                            .addFirstProductPrice(
                              shopProductName,
                              shopsModel.shopName,
                            );
                      }
                      if (state.saved) {
                        Navigator.of(context).pop();
                      }
                      if (state.errorMessage.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child:
                        BlocBuilder<AddShopProductsCubit, AddShopProductsState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (productList
                                .contains(shopProductName.toLowerCase())) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 800),
                                  content:
                                      Text('Istnieje produkt o podanej nazwie'),
                                ),
                              );
                            } else {
                              context
                                  .read<AddShopProductsCubit>()
                                  .addShopProduct(
                                    shopProductName,
                                    productGroup,
                                    svgIcon,
                                  );
                            }
                          },
                          child: const Text(
                            'Dodaj',
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
