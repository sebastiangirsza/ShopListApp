import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/shops/add_shop/cubit/add_shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddShopButton extends StatelessWidget {
  const AddShopButton({
    required this.shopName,
    required this.imageName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final String shopName;
  final String imageName;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddShopCubit>()..getShopProducts(),
      child: BlocListener<AddShopCubit, AddShopState>(
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
        child: BlocBuilder<AddShopCubit, AddShopState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Anuluj',
                        style: GoogleFonts.getFont(
                          'Saira',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: shopName == '' || imagePath == ''
                        ? null
                        : () {
                            context.read<AddShopCubit>().addShop(
                                  imageName + DateTime.now().toString(),
                                  imagePath,
                                  shopName,
                                );
                          },
                    child: const Text(
                      'Dodaj',
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
