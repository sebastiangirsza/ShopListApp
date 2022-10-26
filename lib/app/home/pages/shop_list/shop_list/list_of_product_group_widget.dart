import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/home/pages/shop_list/cubit/product_cubit.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list/list_of_product_group/products_dismissible_widget.dart';
import 'package:shoplistapp/app/repositories/products_repositories.dart';
import 'package:shoplistapp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class ListOfProductsGroupWidget extends StatelessWidget {
  const ListOfProductsGroupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesName = [
      'Warzywa',
      'Mięso',
      'Pieczywo',
      'Suche produkty',
      'Nabiał',
      'Chemia',
      'Inne',
    ];

    final categoriesIcon = [
      'images/icons/vegetable_icon.svg',
      'images/icons/meat_icon.svg',
      'images/icons/bread_icon.svg',
      'images/icons/dry_products_icon.svg',
      'images/icons/dairy_icon.svg',
      'images/icons/chemistry_icon.svg',
      'images/icons/other_icon.svg',
    ];
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0, top: 15),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoriesName.length,
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (context) => ProductCubit(ProductsRepository(
                    ProductRemoteDataSource(), UserRemoteDataSource()))
                  ..products(productGroup: categoriesName[index]),
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final productModels = state.products;
                    final productsNumber = productModels.length.toString();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(3, 3),
                            )
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            trailing:
                                Stack(alignment: Alignment.center, children: [
                              if (productsNumber != '0')
                                Image.asset(
                                  'images/list_icon/list_empty.png',
                                  width: 20,
                                )
                              else
                                Image.asset(
                                  'images/list_icon/list_check.png',
                                  width: 20,
                                ),
                              if (productsNumber != '0')
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    productsNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ]),
                            title: Row(
                              children: [
                                SizedBox(
                                  width: 35,
                                  height: 25,
                                  child: SvgPicture.asset(
                                    categoriesIcon[index],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        categoriesName[index],
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            children: [
                              ProductDismissibleWidget(
                                categoriesName: categoriesName[index],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
