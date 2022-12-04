import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddShopProductImage extends StatefulWidget {
  const AddShopProductImage({
    required this.imageName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final Function(String) imageName;

  final Function(String) imagePath;

  @override
  State<AddShopProductImage> createState() => _AddShopProductImageState();
}

class _AddShopProductImageState extends State<AddShopProductImage> {
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
              allowMultiple: true,
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  width: 150,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/icon/add_photo_icon.png',
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: FileImage(
                        File(image!),
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15,
                      )
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
