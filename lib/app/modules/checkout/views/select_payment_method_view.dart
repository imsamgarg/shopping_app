import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/strings.dart';
import 'package:shopping_app/app/core/values/values.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/modules/checkout/controllers/select_payment_controller.dart';

class SelectPaymentMethodView extends GetView<SelectPaymentMethodController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const _BottomBar(),
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: Padding(
        padding: Sizing.sidePadding,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            if (controller.isCodAvailable)
              Obx(
                () => _CustomTile(
                  value: controller.paymentMethod,
                  groupValue: PaymentMethod.cashOnDelivery,
                  title: 'Cash On Delivery',
                  onPaymentMethodChange: controller.onPaymentMethodChange,
                ),
              ),
            if (controller.isCodAvailable) verSpacing20,
            if (controller.isRazorPayAvailable)
              Obx(
                () => _CustomTile(
                  value: controller.paymentMethod,
                  groupValue: PaymentMethod.prepaid,
                  onPaymentMethodChange: controller.onPaymentMethodChange,
                  title: 'Online Payment',
                ),
              ),
            if (controller.isRazorPayAvailable) verSpacing20,
            _Charges(),
            verSpacing20,
            _DeliveryCharges(),
          ],
        ).scrollVertical(),
      ),
    );
  }
}

////* Mostly Copied From My Old Shitty Project
class _CustomTile extends StatelessWidget {
  const _CustomTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.title,
    this.onPaymentMethodChange,
  }) : super(key: key);

  final ValueChanged<PaymentMethod?>? onPaymentMethodChange;
  final PaymentMethod? value;
  final PaymentMethod groupValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return RadioListTile<PaymentMethod?>(
      value: value,
      selectedTileColor: primaryColor(context),
      activeColor: Vx.white,
      selected: isSelected,
      shape: Sizing.cardShape,
      title: title.text.color(isSelected ? Vx.white : Colors.black).make(),
      groupValue: groupValue,
      onChanged: onPaymentMethodChange,
    )
        .box
        .border(color: Colors.grey, width: !isSelected ? 0.5 : 0)
        .withRounded(value: Sizing.radiusXL)
        .make();
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _Price(),
                _ConfirmOrder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmOrder extends GetView<SelectPaymentMethodController> {
  const _ConfirmOrder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: "Confirm Order"
            .text
            .white
            .make()
            .box
            .padding(
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            )
            .roundedLg
            .outerShadowXl
            .color(primaryColor(context))
            .make()
            .onTap(controller.onConfirmOrder),
      ),
    );
  }
}

class _Price extends GetView<SelectPaymentMethodController> {
  const _Price({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Price(price: controller.totalPrice));
  }
}

class _Charges extends GetView<SelectPaymentMethodController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isFreeDelivery = controller.isFreeDelivery;
        if (controller.paymentMethod == null) return kEmptyWidget;
        return CardSkeleton(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                "Charges"
                    .text
                    .size(18)
                    .color(primaryColor(context))
                    .make()
                    .box
                    .py8
                    .make(),
                "Products Cost : $rsSign${controller.price}"
                    .text
                    .size(17)
                    .make()
                    .box
                    .py8
                    .make(),
                if (!isFreeDelivery)
                  "Delivery Charges : $rsSign${controller.deliveryCharges}"
                      .text
                      .size(17)
                      .make()
                      .box
                      .py8
                      .make(),
                if (!isFreeDelivery)
                  "Add Products Worth $rsSign${controller.freeDelWorth} To Get Free Delivery"
                      .text
                      .size(17)
                      .yellow800
                      .make()
                      .box
                      .py8
                      .make(),
                if (isFreeDelivery)
                  "Free Delivery !!"
                      .text
                      .size(17)
                      .color(primaryColor(context))
                      .make()
                      .box
                      .py8
                      .make(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DeliveryCharges extends StatelessWidget with ServicesMixin {
  @override
  Widget build(BuildContext context) {
    final appData = configService.data!.deliveryConfig!;

    final codCharges = "$rsSign${appData.codCharges}";
    final codFreeOn = "$rsSign${appData.codFreeOn}";

    final prepaidCharges = "$rsSign${appData.razorPayCharges}";
    final prepaidFreeOn = "$rsSign${appData.razorPayFreeOn}";

    final cod = "COD : $codCharges  For Orders Less Then $codFreeOn";
    final prepaid =
        "Online Payment : $prepaidCharges  For Orders Less Then $prepaidFreeOn";

    Widget _textStyle(String text) {
      return text.text.size(17).make().box.py8.make();
    }

    return CardSkeleton(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Delivery Charges"
                .text
                .size(18)
                .color(primaryColor(context))
                .make()
                .box
                .py8
                .make(),
            _textStyle(cod),
            _textStyle(prepaid),
          ],
        ),
      ),
    );
  }
}
