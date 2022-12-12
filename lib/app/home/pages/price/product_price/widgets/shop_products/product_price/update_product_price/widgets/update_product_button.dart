import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/product_price/update_product_price/cubit/update_product_price_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class UpdateProductButton extends StatelessWidget {
  const UpdateProductButton({
    required this.productPrice,
    required this.id,
    Key? key,
  }) : super(key: key);

  final double productPrice;

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdateProductPriceCubit>(),
      child: BlocListener<UpdateProductPriceCubit, UpdateProductPriceState>(
        listener: (context, state) {
          if (state.saved == true) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<UpdateProductPriceCubit, UpdateProductPriceState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.read<UpdateProductPriceCubit>().updateProductPrice(
                      productPrice,
                      id,
                    );
              },
              child: const Text(
                'Dodaj',
              ),
            );
          },
        ),
      ),
    );
  }
}
