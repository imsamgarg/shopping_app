import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CategoriesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CategoriesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
