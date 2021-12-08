import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/modules/product/controllers/products_list_controller.dart';

class ProductsListView extends GetView<ProductsListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductsListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProductsListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
