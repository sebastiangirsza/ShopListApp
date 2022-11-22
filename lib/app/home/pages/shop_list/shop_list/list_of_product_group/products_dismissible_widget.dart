import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/shop_list/cubit/add_product_cubit.dart';
import 'package:shoplistapp/app/home/pages/shop_list/cubit/product_cubit.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list/list_of_product_group/products_dismissible/one_product_widget.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class ProductDismissibleWidget extends StatefulWidget {
  const ProductDismissibleWidget({
    super.key,
    required this.categoriesName,
  });
  final String categoriesName;

  @override
  State<ProductDismissibleWidget> createState() =>
      _ProductDismissibleWidgetState();
}

class _ProductDismissibleWidgetState extends State<ProductDismissibleWidget> {
  var isChecked = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductCubit>(),
      child: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => getIt<ProductCubit>()
              ..products(productGroup: widget.categoriesName),
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                final productModels = state.products;
                return ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    for (final productModel in productModels) ...[
                      if (productModel.productGroup ==
                          widget.categoriesName) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Dismissible(
                            key: UniqueKey(),
                            background: (productModel.isChecked == false)
                                ? const DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 32.0),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.green,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 4.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 32.0),
                                        child: Icon(
                                          Icons.remove_shopping_cart,
                                          color: Colors.red,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                              blurRadius: 4.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            secondaryBackground: const DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.transparent,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 32.0),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 4.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                context
                                    .read<AddProductCubit>()
                                    .delete(documentID: productModel.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 600),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            style: GoogleFonts.getFont('Saira',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                            'Produkt usunięty z listy zakupów'),
                                      ],
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else {
                                context.read<AddProductCubit>().isChecked(
                                    isChecked: !productModel.isChecked,
                                    documentID: productModel.id);

                                (productModel.isChecked == false)
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          duration:
                                              const Duration(milliseconds: 600),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  style: GoogleFonts.getFont(
                                                      'Saira',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                  'Produkt dodany koszyka'),
                                            ],
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),
                                      )
                                    : ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          duration:
                                              const Duration(milliseconds: 600),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  style: GoogleFonts.getFont(
                                                      'Saira',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                  'Produkt usunięty z koszyka'),
                                            ],
                                          ),
                                          backgroundColor: Colors.blue,
                                        ),
                                      );
                              }
                              return null;
                            },
                            child: OneProductWidget(productModel: productModel),
                          ),
                        ),
                      ],
                    ],
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
