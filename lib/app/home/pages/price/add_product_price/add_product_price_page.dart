import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/cubit/add_product_price_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddProductPricePage extends StatefulWidget {
  const AddProductPricePage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductPricePage> createState() => _AddProductPricePageState();
}

class _AddProductPricePageState extends State<AddProductPricePage> {
  late String? productName;
  late double? productPrice;
  late String? shopName;
  late String? imageName;
  late String? imagePath;
  String? downloadURL = 'download_url';

  @override
  void initState() {
    productName = 'productName';
    productPrice = 0.0;
    shopName = 'shopName';
    imageName = 'imageName';
    imagePath = 'imagePath';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductPriceCubit>(),
      child: BlocListener<AddProductPriceCubit, AddProductPriceState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddProductPriceCubit, AddProductPriceState>(
          builder: (context, state) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Color.fromARGB(255, 200, 233, 255),
                    Color.fromARGB(255, 213, 238, 255),
                    Color.fromARGB(255, 228, 244, 255),
                    Color.fromARGB(255, 244, 250, 255),
                  ],
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 200, 233, 255),
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 7.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  elevation: 10,
                  scrolledUnderElevation: 10,
                  toolbarHeight: 60,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  title: Text(
                    'Dodaj produkt',
                    style: GoogleFonts.getFont(
                      'Saira',
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 200, 233, 255),
                      shadows: <Shadow>[
                        const Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  actions: const [],
                ),
                body: ListView(
                  children: [
                    const SizedBox(height: 10),
                    AddProductImage(
                      imageName: (newImageName) {
                        setState(() {
                          imageName = newImageName;
                        });
                      },
                      imagePath: (newImagePath) {
                        setState(() {
                          imagePath = newImagePath;
                        });
                      },
                    ),
                    ProductName(onProductNameChanged: (newProductName) {
                      setState(() {
                        productName = newProductName;
                      });
                    }),
                    ShopName(
                      onNameChanged: (newShopName) {
                        setState(() {
                          shopName = newShopName;
                        });
                      },
                    ),
                    ProductPrice(
                      onProductPriceChanged: (newProductPrice) {
                        setState(() {
                          productPrice = double.tryParse(newProductPrice);
                        });
                      },
                    ),
                    AddProductButton(
                      shopName: shopName!,
                      productName: productName!,
                      productPrice: productPrice!,
                      imageName: imageName!,
                      imagePath: imagePath!,
                      downloadURL: downloadURL!,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

@injectable
class AddProductButton extends StatelessWidget {
  const AddProductButton({
    required this.shopName,
    required this.productName,
    required this.productPrice,
    required this.imageName,
    required this.imagePath,
    required this.downloadURL,
    Key? key,
  }) : super(key: key);

  final String shopName;
  final String productName;
  final double productPrice;
  final String imageName;
  final String imagePath;
  final String downloadURL;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddProductPriceCubit>(),
      child: BlocListener<AddProductPriceCubit, AddProductPriceState>(
        listener: (context, state) {
          if (state.saved == true) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<AddProductPriceCubit, AddProductPriceState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.read<AddProductPriceCubit>().addProductPrice(
                      productName,
                      productPrice,
                      shopName,
                      imageName,
                      imagePath,
                    );
              },
              child: const Text('Dodaj'),
            );
          },
        ),
      ),
    );
  }
}

class ProductName extends StatelessWidget {
  const ProductName({
    Key? key,
    required this.onProductNameChanged,
  }) : super(key: key);

  final Function(String) onProductNameChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: TextField(
        style: GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle:
              GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
          label: const Text('Nazwa produktu'),
        ),
        onChanged: onProductNameChanged,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ShopName extends StatelessWidget {
  const ShopName({
    Key? key,
    required this.onNameChanged,
  }) : super(key: key);

  final Function(String) onNameChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: TextField(
        style: GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle:
              GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
          label: const Text('Nazwa sklepu'),
        ),
        onChanged: onNameChanged,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key? key,
    required this.onProductPriceChanged,
  }) : super(key: key);

  final Function(String) onProductPriceChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: TextField(
        style: GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle:
              GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
          label: const Text('Cena'),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: onProductPriceChanged,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AddProductImage extends StatefulWidget {
  const AddProductImage({
    required this.imageName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final Function(String) imageName;

  final Function(String) imagePath;

  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage> {
  String? image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: InkWell(
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.custom,
              allowedExtensions: ['png', 'jpg'],
            );

            if (result == null) {
              return;
            }

            final path = result.files.single.path!;
            final name = result.files.single.name;
            widget.imagePath(path);
            widget.imageName(name);

            setState(() {
              image = path;
            });
          },
          child: (image == null)
              ? Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black, blurRadius: 15)
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  width: 150,
                  alignment: Alignment.center,
                  child: Image.asset('images/icon/add_photo_icon.png'),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: FileImage(
                        File(image!),
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(color: Colors.black, blurRadius: 15)
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  width: 150,
                  alignment: Alignment.center,
                ),
        ),
      ),
    );
  }
}
