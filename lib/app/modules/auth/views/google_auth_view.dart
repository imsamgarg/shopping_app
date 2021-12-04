import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GoogleAuthView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoogleAuthView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'GoogleAuthView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
