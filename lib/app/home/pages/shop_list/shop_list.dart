import 'package:ShopListApp/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_bread.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_dairy.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_dry_products.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_household_chemicals.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_meat.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_other.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/widgets/categories_widget_vegetables.dart';
import 'package:ShopListApp/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:ShopListApp/app/repositories/products_repositories.dart';
import 'package:ShopListApp/data/remote_data_sources/product_remote_data_source.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

class ShopListPage extends StatefulWidget {
  const ShopListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ShopListPage> createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  String? productGroup;
  String? productName;

  int productQuantity = 1;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 15),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              children: const [
                _ProductsGroupVegetables(),
                _ProductsGroupMeat(),
                _ProductsGroupBread(),
                _ProductsGroupDryProducts(),
                _ProductsGroupDairy(),
                _ProductsGroupHouseholdChemicals(),
                _ProductsGroupOther()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: 210,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              elevation: 15,
              backgroundColor: Colors.green,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                    title: Text(
                      style: GoogleFonts.getFont('Saira',
                          fontWeight: FontWeight.bold),
                      'Dodaj produkt do listy',
                      textAlign: TextAlign.center,
                    ),
                    content: SizedBox(
                      height: 223,
                      child: Column(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                label: Text(
                                    style: GoogleFonts.getFont('Saira'),
                                    'Kategoria')),
                            isExpanded: true,
                            value: productGroup,
                            onChanged: (newProduct) {
                              setState(() {
                                productGroup = newProduct!;
                              });
                            },
                            items: <String>[
                              'Warzywa',
                              'Mięso',
                              'Pieczywo',
                              'Suche produkty',
                              'Nabiał',
                              'Chemia',
                              'Inne',
                            ].map<DropdownMenuItem<String>>(
                              (productGroup) {
                                return DropdownMenuItem<String>(
                                  value: productGroup,
                                  child: Center(
                                    child: Text(
                                      style: GoogleFonts.getFont('Saira'),
                                      productGroup,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          TextField(
                            style: GoogleFonts.getFont('Saira'),
                            decoration: InputDecoration(
                                label: Text(
                                    style: GoogleFonts.getFont('Saira'),
                                    'Nazwa produktu')),
                            onChanged: (newProduct) {
                              setState(() {
                                productName = newProduct;
                              });
                            },
                            textAlign: TextAlign.center,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 9,
                              ),
                              Text(
                                  style: GoogleFonts.getFont('Saira'),
                                  'Ilość: '),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: NumberPicker(
                                  itemHeight: 24,
                                  itemWidth: 40,
                                  axis: Axis.horizontal,
                                  value: productQuantity,
                                  minValue: 1,
                                  maxValue: 100,
                                  itemCount: 5,
                                  onChanged: (value) =>
                                      setState(() => productQuantity = value),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cofnij',
                            style: GoogleFonts.getFont('Saira',
                                color: Colors.white),
                          )),
                      BlocProvider(
                        create: (context) => AddCubit(ProductsRepository(
                            ProductRemoteDataSource(), UserRemoteDataSource())),
                        child: BlocBuilder<AddCubit, AddState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: productGroup == null ||
                                      productName == null
                                  ? null
                                  : () {
                                      context.read<AddCubit>().add(
                                            productGroup!,
                                            productName!,
                                            productQuantity,
                                            isChecked,
                                          );
                                      ScaffoldMessenger.of(context)
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
                                                  'Produkt dodany do listy'),
                                            ],
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                              child: Text(
                                  style: GoogleFonts.getFont('Saira'),
                                  'Dodaj do listy'),
                            );
                          },
                        ),
                      )
                    ],
                  );
                });
              }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  style: GoogleFonts.getFont('Saira',
                      color: Colors.white, fontWeight: FontWeight.bold),
                  'Dodaj produkt do listy'),
              const SizedBox(width: 5),
              const Icon(Icons.add, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductsGroupVegetables extends StatelessWidget {
  const _ProductsGroupVegetables({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..vegetables(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                              'Warzywa',
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: const [
                          SizedBox(height: 10),
                          CategoriesWidgetVegetables(),
                        ],
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

class _ProductsGroupMeat extends StatelessWidget {
  const _ProductsGroupMeat({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..meat(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(height: 10),
                          CategoriesWidgetMeat(),
                        ],
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

class _ProductsGroupBread extends StatelessWidget {
  const _ProductsGroupBread({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..bread(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                              'Pieczywo',
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: const [
                          SizedBox(height: 10),
                          CategoriesWidgetBread(),
                        ],
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

class _ProductsGroupDryProducts extends StatelessWidget {
  const _ProductsGroupDryProducts({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..dryProducts(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                              'Suche produkty',
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: const [
                          SizedBox(height: 10),
                          CategoriesWidgetDryProducts(),
                        ],
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

class _ProductsGroupDairy extends StatelessWidget {
  const _ProductsGroupDairy({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..dairy(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                              'Nabiał',
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: const [
                          SizedBox(height: 10),
                          CategoriesWidgetDairy(),
                        ],
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

class _ProductsGroupHouseholdChemicals extends StatelessWidget {
  const _ProductsGroupHouseholdChemicals({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..householdChemicals(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                              'Chamia',
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: const [
                          SizedBox(height: 10),
                          CategoriesWidgetHouseholdChemicals(),
                        ],
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

class _ProductsGroupOther extends StatelessWidget {
  const _ProductsGroupOther({
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
                      child: ExpansionTile(
                        trailing: BlocProvider(
                          create: (context) => AddCubit(ProductsRepository(
                              ProductRemoteDataSource(),
                              UserRemoteDataSource())),
                          child: BlocBuilder<AddCubit, AddState>(
                            builder: (context, state) {
                              return BlocProvider(
                                create: (context) => ProductCubit(
                                    ProductsRepository(
                                        ProductRemoteDataSource(),
                                        UserRemoteDataSource()))
                                  ..other(),
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  builder: (context, state) {
                                    final productModels = state.products;

                                    for (final productModel in productModels) {
                                      null;
                                    }

                                    return Text(
                                        productModels.length.toString());
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                              'Inne',
                              style: GoogleFonts.getFont('Saira',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        children: const [
                          SizedBox(height: 10),
                          CategoriesWidgetOther(),
                        ],
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
