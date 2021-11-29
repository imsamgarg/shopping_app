import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/phone_auth_controller.dart';

class PhoneAuthView extends GetView<PhoneAuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PhoneAuthView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PhoneAuthView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
