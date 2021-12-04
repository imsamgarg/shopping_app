import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PhoneAuthView extends GetView {
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
