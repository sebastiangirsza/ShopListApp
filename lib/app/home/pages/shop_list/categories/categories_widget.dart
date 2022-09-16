import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:shoplistappsm/app/home/pages/your_products/cubit/your_products_cubit.dart';
import 'package:shoplistappsm/app/models/product_model.dart';
import 'package:shoplistappsm/app/repositories/products_repositories.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({
    required this.categoriesName,
    super.key,
  });
  final String categoriesName;

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(ProductsRepository()),
      child: BlocBuilder<AddCubit, AddState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProductCubit(ProductsRepository())..start(),
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
                          if (productModel.productGroup ==
                              widget.categoriesName) ...[
                            const SizedBox(height: 5),
                            _Dismissible(productModel: productModel),
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

class _Dismissible extends StatelessWidget {
  const _Dismissible({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(ProductsRepository()),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          return Dismissible(
            key: UniqueKey(),
            background: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 32.0),
                  child: Icon(
                    Icons.delete_outline,
                  ),
                ),
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                context.read<AddCubit>().delete(documentID: productModel.id);
              } else {
                // context.read<AddCubit>().delete(documentID: productModel.id);
              }
            },
            //  (right) async {return right == DismissDirection.startToEnd},

            child: _ProductsList(productModel: productModel),
          );
        },
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  const _ProductsList({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.green,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black, blurRadius: 15)
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productModel.productName,
                style: const TextStyle(fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    productModel.productQuantity.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(221, 179, 255, 155),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return _AlertDialog(productModel: productModel);
                          });
                      context
                          .read<AddCubit>()
                          .delete(documentID: productModel.id);
                    },
                    child: const Icon(
                        size: 17,
                        color: Colors.black,
                        Icons.shopping_bag_outlined),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _AlertDialog extends StatelessWidget {
  const _AlertDialog({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YourProductsCubit(ProductsRepository())..start(),
      child: BlocBuilder<YourProductsCubit, YourProductsState>(
        builder: (context, state) {
          String? storageName;
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                content: DropdownButtonFormField(
                  decoration: const InputDecoration(
                      label: Text('Miejsce przechowywania')),
                  isExpanded: true,
                  value: storageName,
                  onChanged: (newProduct) {
                    setState(() {
                      storageName = newProduct!;
                    });
                  },
                  items: <String>[
                    'Lodówka',
                    'Zamrażarka',
                    'Szafka kuchenna',
                    'Chemia',
                    'Inne',
                  ].map<DropdownMenuItem<String>>(
                    (storageName) {
                      return DropdownMenuItem<String>(
                        value: storageName,
                        child: Text(
                          storageName,
                        ),
                      );
                    },
                  ).toList(),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<YourProductsCubit>().addYourProduct(
                            productModel.productGroup,
                            productModel.productName,
                            productModel.productQuantity,
                            storageName!,
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dodaj'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
