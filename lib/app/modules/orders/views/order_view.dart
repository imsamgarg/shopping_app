import 'package:flutter/material.dart';

import 'package:get/get.dart';

class OrderView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
