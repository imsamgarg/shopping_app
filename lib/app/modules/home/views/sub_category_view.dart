import 'package:flutter/material.dart';
import 'package:shopping_app/app/data/models/category_model.dart';

class SubCategoryView extends StatelessWidget {
  final Category category;

  SubCategoryView(this.category);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubCategoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubCategoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
