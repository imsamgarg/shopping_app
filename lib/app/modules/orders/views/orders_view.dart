import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrdersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrdersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
