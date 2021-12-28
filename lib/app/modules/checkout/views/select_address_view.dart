import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/modules/checkout/controllers/select_address_controller.dart';

class SelectAddressView extends StatelessWidget {
  final controller = Get.put(SelectAddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SelecAddressView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SelecAddressView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
