import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/navbar.dart';
import 'package:shopping_app/app/modules/home/views/favourite_view.dart';
import 'package:shopping_app/app/modules/home/views/profile_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      bottomNavigationBar: AppNavbar(onIndexChange: controller.onIndexChange),
      body: IndexedStack(
        index: controller.index,
        children: [
          _HomeView(),
          FavouriteView(),
          ProfileView(),
        ],
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
