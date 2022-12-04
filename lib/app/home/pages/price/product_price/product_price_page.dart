import 'package:flutter/material.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/shop_products/shop_products_list.dart';
import 'package:shoplistapp/app/home/pages/price/product_price/widgets/title_and_elvated_button.dart';

class ProductPricePage extends StatelessWidget {
  const ProductPricePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      children: const [
        TitleAndElevatedButton(),
        ShopProductsList(),
      ],
    );
  }
}
