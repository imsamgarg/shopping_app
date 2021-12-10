import 'package:flutter/material.dart';

// import 'package:get/get.dart';
import 'package:shopping_app/app/data/models/app_model.dart';
// import 'package:shopping_app/app/modules/home/controllers/tap_controller.dart';

class SubCategoryView extends StatelessWidget {
  final Category category;

  SubCategoryView(this.category);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SubCategoryView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SubCategoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
