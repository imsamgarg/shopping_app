import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';

import '../controllers/startup_controller.dart';

class StartupView extends GetView<StartupController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: CenterLoading(
        size: 60,
      ),
    );
  }
}
