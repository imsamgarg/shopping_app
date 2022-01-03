import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:shopping_app/app/modules/checkout/controllers/select_payment_controller.dart';

class SelectPaymentMethodView extends GetView<SelectPaymentMethodController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SelectPaymentMethodView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SelectPaymentMethodView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
