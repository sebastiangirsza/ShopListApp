import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_product_price/cubit/add_product_price_cubit.dart';
import 'package:shoplistapp/app/home/pages/price/shop/cubit/shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';
import 'package:shoplistapp/app/models/shop_products_model.dart';

@injectable
class AddProductPricePage extends StatefulWidget {
  const AddProductPricePage({
    required this.shopProductModel,
    Key? key,
  }) : super(key: key);

  final ShopProductsModel shopProductModel;
  @override
  State<AddProductPricePage> createState() => _AddProductPricePageState();
}

class _AddProductPricePageState extends State<AddProductPricePage> {
  late String? productName;
  late double? productPrice;
  late String? shopName;
  late String? downloadURL;
  late String? shopDownloadURL;
  dynamic chosenShop;

  @override
  void initState() {
    productName = 'productName';
    productPrice = 0.0;
    shopName = 'shopName';
    downloadURL = 'downloadURL';
    shopDownloadURL = 'shopDownloadURL';
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
                    ChooseShop(
                      onShopChanged: (newShop) {
                        setState(() {
                          chosenShop = newShop;
                          shopName = newShop.shopName.toString();
                          shopDownloadURL = newShop.downloadURL.toString();
                        });
                      },
                      chosenShop: chosenShop,
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
                      productName: widget.shopProductModel.shopProductName,
                      productPrice: productPrice!,
                      downloadURL: widget.shopProductModel.downloadURL,
                      shopDownloadURL: shopDownloadURL!,
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
class ChooseShop extends StatelessWidget {
  const ChooseShop({
    required this.onShopChanged,
    required this.chosenShop,
    Key? key,
  }) : super(key: key);

  final Function(dynamic) onShopChanged;
  final dynamic chosenShop;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopCubit>()..start(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          final shopModels = state.shops;
          List<DropdownMenuItem> shopsList = [];
          for (final shopModel in shopModels) {
            shopsList.add(
              DropdownMenuItem(
                value: shopModel,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              shopModel.downloadURL,
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text(
                      shopModel.shopName,
                      style: GoogleFonts.getFont('Saira',
                          fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(
            height: 65,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text(
                    style: GoogleFonts.getFont('Saira',
                        fontSize: 12, color: Colors.black),
                    'Wybierz sklep'),
                borderRadius: BorderRadius.circular(10),
                iconDisabledColor: Colors.black,
                iconEnabledColor: Colors.black,
                dropdownColor: Colors.white,
                isExpanded: true,
                items: shopsList,
                onChanged: onShopChanged,
                value: chosenShop,
              ),
            ),
          );
        },
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
    required this.downloadURL,
    required this.shopDownloadURL,
    Key? key,
  }) : super(key: key);

  final String shopName;
  final String productName;
  final double productPrice;
  final String downloadURL;
  final String shopDownloadURL;

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
                      downloadURL,
                      shopDownloadURL,
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

// class ProductName extends StatelessWidget {
//   const ProductName({
//     Key? key,
//     required this.onProductNameChanged,
//   }) : super(key: key);

//   final Function(String) onProductNameChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 65,
//       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: Colors.white),
//       child: Center(
//         child: TextField(
//           style:
//               GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             labelStyle:
//                 GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
//             label: const Text('Nazwa produktu'),
//           ),
//           onChanged: onProductNameChanged,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key? key,
    required this.onProductPriceChanged,
  }) : super(key: key);

  final Function(String) onProductPriceChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white),
      child: Center(
        child: TextField(
          style:
              GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle:
                GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
            label: const Text('Cena'),
          ),
          keyboardType: TextInputType.number,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.digitsOnly
          // ],
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
          ],
          onChanged: onProductPriceChanged,
          textAlign: TextAlign.center,
        ),
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
