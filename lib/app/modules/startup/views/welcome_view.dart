import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetView;
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/custom_painter.dart';
import 'package:shopping_app/app/core/values/assets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shopping_app/app/modules/startup/controllers/startup_controller.dart';

class WelcomeView extends GetView<StartupController> {
  const WelcomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: context.screenHeight,
              width: context.screenWidth,
              child: CustomPaint(
                painter: BottomWavePainter(Theme.of(context).primaryColor),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.assetsImagesWelcome,
                          height: 300,
                          width: 300,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        "Welcome To Fashion 24/7 ".text.size(24).make(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: TextButton.icon(
                        onPressed: controller.onNextTap,
                        label: "Next".text.size(22).make(),
                        icon: Icon(Icons.arrow_forward_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
