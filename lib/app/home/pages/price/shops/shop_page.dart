import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/shops/add_shop/add_shop_page.dart';
import 'package:shoplistapp/app/home/pages/price/shops/cubit/shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class ShopPage extends StatelessWidget {
  const ShopPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopCubit>()..start(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          final shopModels = state.shops;
          return GridView.count(
            crossAxisCount: 3,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (final shopModel in shopModels) ...[
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 90,
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
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage(
                            shopModel.downloadURL,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      shopModel.shopName,
                      style: GoogleFonts.getFont(
                        'Saira',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AddShopPage();
                      });
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: 90,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
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
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    const Text(
                      '',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
