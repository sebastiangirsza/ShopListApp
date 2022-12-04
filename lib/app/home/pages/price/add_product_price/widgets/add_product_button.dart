import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/cubit/add_product_price_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddProductButton extends StatelessWidget {
  const AddProductButton({
    required this.shopName,
    required this.productName,
    required this.productPrice,
    required this.downloadURL,
    required this.shopDownloadURL,
    Key? key,
  }) : super(key: key);

  final String shopName;
  final String productName;
  final double productPrice;
  final String downloadURL;
  final String shopDownloadURL;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductPriceCubit>(),
      child: BlocListener<AddProductPriceCubit, AddProductPriceState>(
        listener: (context, state) {
          if (state.saved == true) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<AddProductPriceCubit, AddProductPriceState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.read<AddProductPriceCubit>().addProductPrice(
                      productName,
                      productPrice,
                      shopName,
                      downloadURL,
                      shopDownloadURL,
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
