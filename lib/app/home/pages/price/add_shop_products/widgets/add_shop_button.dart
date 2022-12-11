import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/cubit/add_shop_product_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/shops/cubit/shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddShopButton extends StatelessWidget {
  const AddShopButton({
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
      create: (context) => getIt<AddShopProductsCubit>(),
      child: BlocListener<AddShopProductsCubit, AddShopProductsState>(
        listener: (context, state) {
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
        child: BlocBuilder<AddShopProductsCubit, AddShopProductsState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<ShopCubit>()..start(),
              child: BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {
                  final shopsModels = state.shops;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      context.read<AddShopProductsCubit>().addShopProduct(
                            shopProductName,
                            productGroup,
                            svgIcon,
                          );
                      for (final shopsModel in shopsModels) {
                        context
                            .read<AddShopProductsCubit>()
                            .addFirstProductPrice(
                              shopProductName,
                              shopsModel.downloadURL,
                            );
                      }
                    },
                    child: const Text(
                      'Dodaj',
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
