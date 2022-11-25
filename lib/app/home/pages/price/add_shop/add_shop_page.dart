import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/add_shop/cubit/add_shop_cubit.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class AddShopPage extends StatefulWidget {
  const AddShopPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  late String? shopName;
  late String? imageName;
  late String? imagePath;
  String? downloadURL = 'download_url';

  @override
  void initState() {
    shopName = 'shopName';
    imageName = 'imageName';
    imagePath = 'imagePath';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            'Dodaj sklep',
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
            AddShopLogo(
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
            ShopName(
              onNameChanged: (newShopName) {
                setState(() {
                  shopName = newShopName;
                });
              },
            ),
            AddShopButton(
              shopName: shopName!,
              imageName: imageName!,
              imagePath: imagePath!,
            ),
          ],
        ),
      ),
    );
  }
}

@injectable
class AddShopButton extends StatelessWidget {
  const AddShopButton({
    required this.shopName,
    required this.imageName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final String shopName;
  final String imageName;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddShopCubit>(),
      child: BlocListener<AddShopCubit, AddShopState>(
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
        child: BlocBuilder<AddShopCubit, AddShopState>(
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                context.read<AddShopCubit>().addShop(
                      imageName,
                      imagePath,
                      shopName,
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

class AddShopLogo extends StatefulWidget {
  const AddShopLogo({
    required this.imageName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final Function(String) imageName;

  final Function(String) imagePath;

  @override
  State<AddShopLogo> createState() => _AddShopLogoState();
}

class _AddShopLogoState extends State<AddShopLogo> {
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
