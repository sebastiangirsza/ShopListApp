import 'package:ShopListApp/app/home/pages/shop_list/categories/categories_widget_global.dart';
import 'package:ShopListApp/app/home/pages/shop_list/categories/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
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
  String? productTypeName;
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
                ProductsGroup(),
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
              backgroundColor: const Color.fromARGB(255, 0, 63, 114),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)))),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(255, 0, 63, 114),
                    content: SizedBox(
                      height: 270,
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Text(
                            style: GoogleFonts.getFont('Saira',
                                fontWeight: FontWeight.bold),
                            'Dodaj produkt do listy',
                            textAlign: TextAlign.center,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                label: Text(
                                    style: GoogleFonts.getFont('Saira',
                                        fontSize: 12),
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
                                      style: GoogleFonts.getFont('Saira',
                                          fontSize: 12),
                                      productGroup,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          TextField(
                            style: GoogleFonts.getFont('Saira', fontSize: 12),
                            decoration: InputDecoration(
                                label: Text(
                                    style: GoogleFonts.getFont('Saira',
                                        fontSize: 12),
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
                                height: 4,
                              ),
                              Text(
                                  style: GoogleFonts.getFont('Saira',
                                      fontSize: 12),
                                  'Ilość: '),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
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
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                                label: Text(
                                    style: GoogleFonts.getFont('Saira',
                                        fontSize: 12),
                                    'Rodzaj opakowania')),
                            isExpanded: true,
                            value: productTypeName,
                            onChanged: (newProduct) {
                              setState(() {
                                productTypeName = newProduct!;
                              });
                            },
                            items: <String>[
                              'sztuka',
                              'karton',
                              'porcja (50 g)',
                              'paczka',
                            ].map<DropdownMenuItem<String>>(
                              (productTypeName) {
                                return DropdownMenuItem<String>(
                                  value: productTypeName,
                                  child: Center(
                                    child: Text(
                                      style: GoogleFonts.getFont('Saira',
                                          fontSize: 12),
                                      productTypeName,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
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
                                      productName == null ||
                                      productTypeName == null
                                  ? null
                                  : () {
                                      context.read<AddCubit>().add(
                                            productGroup!,
                                            productName!,
                                            productQuantity,
                                            isChecked,
                                            productTypeName!,
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

class ProductsGroup extends StatelessWidget {
  const ProductsGroup({
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
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categoriesName.length,
      itemBuilder: (context, index) {
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 1,
                                offset: Offset(1, 1)),
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(-4, -4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: BlocProvider(
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
                                    ..products(
                                        productGroup: categoriesName[index]),
                                  child:
                                      BlocBuilder<ProductCubit, ProductState>(
                                    builder: (context, state) {
                                      final productModels = state.products;
                                      final productsNumber =
                                          productModels.length.toString();

                                      return ExpansionTile(
                                        trailing: Stack(
                                            alignment: Alignment.center,
                                            children: [
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0),
                                                  child: Text(
                                                    productsNumber,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(null),
                                            Text(
                                              categoriesName[index],
                                              style: GoogleFonts.getFont(
                                                  'Saira',
                                                  fontSize: 20,
                                                  color: const Color.fromARGB(
                                                      255, 0, 63, 114),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        children: [
                                          CategoriesWidget(
                                            categoriesName:
                                                categoriesName[index],
                                          ),
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
      },
    );
  }
}
