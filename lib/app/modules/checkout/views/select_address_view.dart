import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/global_widgets/widgets.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/data/models/user_models/address_model.dart';
import 'package:shopping_app/app/modules/address/controllers/address_list_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shopping_app/app/modules/checkout/controllers/select_address_controller.dart';

class SelectAddressView extends StatelessWidget {
  final controller = Get.put(SelectAddressController());
  final addressListController = Get.put(AddressListController());

  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      future: addressListController.instance,
      builder: (snapshot) {
        return Scaffold(
          bottomNavigationBar: const _BottomBar(),
          appBar: AppBar(
            title: const Text('Select Address'),
          ),
          body: GetBuilder<AddressListController>(
            init: addressListController,
            builder: (_) {
              final addressList = addressListController.addresses;
              final addressCount = addressList.length;
              if (addressCount == 0) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        "No Addresses Saved!"
                            .text
                            .size(16)
                            .make()
                            .box
                            .py12
                            .make(),
                        horSpacing10,
                        AppTextButton(
                          onTap: addressListController.onAddAddressTap,
                          child: const Text("Add Address"),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Padding(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Obx(
                      () => _CustomTile(
                        address: addressList[index],
                        value: controller.selectedAddress,
                        groupValue: index,
                        onAddressChange: controller.onAddressChanged,
                      ),
                    );
                  },
                  itemCount: addressCount,
                ),
                padding: const EdgeInsets.only(top: 10),
              );
            },
          ),
        );
      },
    );
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    Key? key,
    this.value,
    this.onAddressChange,
    required this.address,
    required this.groupValue,
  }) : super(key: key);

  final Address address;
  final int? value;
  final int groupValue;
  final ValueChanged<int?>? onAddressChange;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return RadioListTile<int?>(
      value: value,
      selected: isSelected,
      tileColor: Vx.white,
      shape: Sizing.cardShape,
      title: AddressCard(address: address),
      groupValue: groupValue,
      onChanged: onAddressChange,
    )
        .box
        .border(color: Colors.grey, width: 0.5)
        .withRounded(value: Sizing.radiusXL)
        .make();
  }
}

class AddressCard extends StatelessWidget {
  final Address address;

  const AddressCard({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: address.toString().text.size(16).make(),
        ),
      ),
    );
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

class _ConfirmOrder extends GetView<SelectAddressController> {
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
            .padding(const EdgeInsets.symmetric(horizontal: 24, vertical: 16))
            .roundedLg
            .outerShadowXl
            .color(primaryColor(context))
            .make()
            .onTap(controller.onConfirmOrder),
      ),
    );
  }
}

class _Price extends GetView<SelectAddressController> {
  const _Price({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Price(price: controller.totalPrice));
  }
}
