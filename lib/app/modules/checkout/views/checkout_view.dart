import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckoutView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CheckoutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
