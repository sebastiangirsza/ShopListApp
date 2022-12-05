import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/cubit/add_product_price_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop_products/cubit/add_shop_product_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddShopButton extends StatelessWidget {
  const AddShopButton({
    required this.shopProductName,
    required this.imageName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final String shopProductName;
  final String imageName;
  final String imagePath;

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
              create: (context) => getIt<AddProductPriceCubit>(),
              child: BlocBuilder<AddProductPriceCubit, AddProductPriceState>(
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      context.read<AddShopProductsCubit>().addShopProduct(
                            imageName + DateTime.now().toString(),
                            imagePath,
                            shopProductName,
                          );
                      // context.read<AddProductPriceCubit>().addFirstProductPrice(
                      //       shopProductName,
                      //     );
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
