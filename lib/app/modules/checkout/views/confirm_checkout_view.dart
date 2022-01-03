import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ConfirmCheckoutView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConfirmCheckoutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ConfirmCheckoutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
