import 'package:ShopListApp/app/home/pages/shop_list/categories/categories_widget_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:ShopListApp/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:ShopListApp/app/repositories/products_repositories.dart';
import 'package:ShopListApp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

class CategoriesWidgetDairy extends StatefulWidget {
  const CategoriesWidgetDairy({
    super.key,
  });

  @override
  State<CategoriesWidgetDairy> createState() => _CategoriesWidgetDairyState();
}

class _CategoriesWidgetDairyState extends State<CategoriesWidgetDairy> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ProductsRepository(
          ProductRemoteDataSource(), UserRemoteDataSource())),
      child: BlocBuilder<AddCubit, AddState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProductCubit(ProductsRepository(
                ProductRemoteDataSource(), UserRemoteDataSource()))
              ..dairy(),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final productModels = state.products;
                return ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        for (final productModel in productModels) ...[
                          if (productModel.productGroup == 'Nabiał') ...[
                            const SizedBox(height: 5),
                            DismissibleWidget(productModel: productModel),
                            const SizedBox(height: 5)
                          ],
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
