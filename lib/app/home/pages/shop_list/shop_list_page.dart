import 'package:flutter/material.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list/floating_action_button_widget.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list/list_of_product_group_widget.dart';

class ShopListPage extends StatelessWidget {
  const ShopListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ListOfProductsGroupWidget(),
      // floatingActionButton: FloatingActionButtonWidget()
    );
  }
}
