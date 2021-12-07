import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FavouriteView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FavouriteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'FavouriteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
