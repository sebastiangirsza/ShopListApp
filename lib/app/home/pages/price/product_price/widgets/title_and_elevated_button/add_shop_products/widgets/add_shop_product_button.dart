import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/title_and_elevated_button/add_shop_products/cubit/add_shop_product_cubit.dart';
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
      create: (context) =>
          getIt<AddShopProductsCubit>()..getShopProductsStream(),
      child: BlocBuilder<AddShopProductsCubit, AddShopProductsState>(
        builder: (context, state) {
          final shopProductNamesList = state.shopProductsNames;
          return BlocProvider(
            create: (context) =>
                getIt<AddShopProductsCubit>()..getShopsStream(),
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
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      if (shopProductNamesList
                          .contains(shopProductName.toLowerCase())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 800),
                            content: Text('Istnieje produkt o podanej nazwie'),
                          ),
                        );
                      } else {
                        context.read<AddShopProductsCubit>().addShopProduct(
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
  }
}
