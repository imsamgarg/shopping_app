import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CheckoutSuccessfullView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckoutSuccessfullView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CheckoutSuccessfullView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
