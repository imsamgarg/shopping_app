import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductsListView extends GetView {
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
