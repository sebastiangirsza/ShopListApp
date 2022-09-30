import 'package:ShopListApp/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_meat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ShopListApp/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:ShopListApp/app/repositories/products_repositories.dart';
import 'package:ShopListApp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

class ProductsGroupMeat extends StatelessWidget {
  const ProductsGroupMeat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SizedBox(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 63, 114),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black, blurRadius: 15)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: BlocProvider(
                        create: (context) => AddCubit(ProductsRepository(
                            ProductRemoteDataSource(), UserRemoteDataSource())),
                        child: BlocBuilder<AddCubit, AddState>(
                          builder: (context, state) {
                            return BlocProvider(
                              create: (context) => ProductCubit(
                                  ProductsRepository(ProductRemoteDataSource(),
                                      UserRemoteDataSource()))
                                ..meat(),
                              child: BlocBuilder<ProductCubit, ProductState>(
                                builder: (context, state) {
                                  final productModels = state.products;
                                  final productsNumber =
                                      productModels.length.toString();
                                  for (final productModel in productModels) {
                                    null;
                                  }
                                  return ExpansionTile(
                                    trailing: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                            'images/list_icon/list_empty.png',
                                            width: 20,
                                          ),
                                          Text(productsNumber)
                                        ]),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(null),
                                        Text(
                                          'Mięso',
                                          style: GoogleFonts.getFont('Saira',
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    children: const [
                                      CategoriesWidgetMeat(),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
