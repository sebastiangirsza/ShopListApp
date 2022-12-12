import 'package:flutter/material.dart';
import 'package:shoplistapp/app/home/pages/price/shops/add_shop/widgets/add_shop_button.dart';
import 'package:shoplistapp/app/home/pages/price/shops/add_shop/widgets/add_shop_logo.dart';
import 'package:shoplistapp/app/home/pages/price/shops/add_shop/widgets/add_shop_name.dart';

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
    shopName = '';
    imageName = '';
    imagePath = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 200, 233, 255),
          content: Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            child: ListView(
              shrinkWrap: true,
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
                AddShopName(
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
      },
    );
  }
}
