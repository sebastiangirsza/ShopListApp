import 'package:ShopListApp/app/home/pages/shop_list/categories/categories_widget_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:ShopListApp/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:ShopListApp/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:ShopListApp/app/models/product_model.dart';
import 'package:ShopListApp/app/repositories/products_repositories.dart';
import 'package:ShopListApp/app/repositories/purchased_products_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/purchased_product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

class CategoriesWidgetVegetables extends StatefulWidget {
  const CategoriesWidgetVegetables({
    super.key,
  });

  @override
  State<CategoriesWidgetVegetables> createState() =>
      _CategoriesWidgetVegetablesState();
}

class _CategoriesWidgetVegetablesState
    extends State<CategoriesWidgetVegetables> {
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
              ..vegetables(),
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
                          if (productModel.productGroup == 'Warzywa') ...[
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
