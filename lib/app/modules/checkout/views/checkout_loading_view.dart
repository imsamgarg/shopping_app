import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/modules/checkout/controllers/payment_controller.dart';

class CheckoutLoadingView extends StatelessWidget {
  final controller = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckoutLoadingView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CheckoutLoadingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
