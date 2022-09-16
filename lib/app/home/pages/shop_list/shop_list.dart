import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/categories/categories_widget.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/cubit/add_cubit.dart';
import 'package:shoplistappsm/app/repositories/products_repositories.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70, right: 70, top: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  elevation: 15,
                  backgroundColor: const Color.fromARGB(255, 173, 255, 141),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return AlertDialog(
                        backgroundColor: Colors.blueGrey,
                        title: const Text(
                          'Dodaj produkt do listy',
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          height: 300,
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    label: Text('Kategoria')),
                                isExpanded: true,
                                value: productGroup,
                                onChanged: (newProduct) {
                                  setState(() {
                                    productGroup = newProduct!;
                                  });
                                },
                                items: <String>[
                                  'Mięso',
                                  'Warzywa',
                                ].map<DropdownMenuItem<String>>(
                                  (productGroup) {
                                    return DropdownMenuItem<String>(
                                      value: productGroup,
                                      child: Text(
                                        productGroup,
                                        // style: const TextStyle(color: Colors.black),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                    label: Text('Nazwa produktu')),
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
                                    height: 15,
                                  ),
                                  const Text('Ilość: '),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: NumberPicker(
                                      itemHeight: 25,
                                      itemWidth: 40,
                                      axis: Axis.horizontal,
                                      value: productQuantity,
                                      minValue: 1,
                                      maxValue: 100,
                                      itemCount: 5,
                                      onChanged: (value) => setState(
                                          () => productQuantity = value),
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
                              child: const Text(
                                'Cofnij',
                                style: TextStyle(color: Colors.black),
                              )),
                          BlocProvider(
                            create: (context) => AddCubit(ProductsRepository()),
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
                                              );
                                          Navigator.of(context).pop();
                                        },
                                  child: const Text('Dodaj do listy'),
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
                children: const [
                  Text(
                      style: TextStyle(color: Colors.black),
                      'Dodaj produkt do listy'),
                  SizedBox(width: 5),
                  Icon(Icons.add, color: Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const _ProductsGroup(),
        ],
      ),
    );
  }
}

class _ProductsGroup extends StatelessWidget {
  const _ProductsGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesName = [
      'Warzywa',
      'Mięso',
      'Pieczywo',
      // 'Suche produkty',
      // 'Nabiał',
      // 'Chemia',
      // 'Inne',
    ];
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView.builder(
            shrinkWrap: true, // auto height
            itemCount: categoriesName.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black, blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 47, 148, 0)),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        trailing: const Icon(null),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(null),
                            Text(
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                                categoriesName[index]),
                          ],
                        ),
                        children: [
                          const SizedBox(height: 10),
                          CategoriesWidget(
                              categoriesName: categoriesName[index]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
