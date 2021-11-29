import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/startup_controller.dart';

class StartupView extends GetView<StartupController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StartupView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'StartupView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
