import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop/add_shop_page.dart';
import 'package:shoplistapp/app/home/pages/price/shop/cubit/shop_cubit.dart';

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
            crossAxisCount: 2,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (final shopModel in shopModels) ...[
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          boxShadow: const <BoxShadow>[
                            BoxShadow(color: Colors.black, blurRadius: 15)
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white,
                          image: DecorationImage(
                              image: NetworkImage(
                                shopModel.downloadURL,
                              ),
                              fit: BoxFit.contain)),
                    ),
                    Text(shopModel.shopName)
                  ],
                ),
              ],
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddShopPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black, blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 70,
                      ),
                    ),
                    const Text(''),
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
