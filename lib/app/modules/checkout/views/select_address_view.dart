import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
        return GetBuilder<AddressListController>(
          init: addressListController,
          builder: (_) {
            final addressList = addressListController.addresses;

            final isAddressEmpty = addressList.isEmpty;
            if (isAddressEmpty) _EmptyBody(isAddressEmpty: isAddressEmpty);

            return _Body(addressList: addressList);
          },
        );
      },
    );
  }
}

class _Body extends GetView<SelectAddressController> {
  const _Body({
    Key? key,
    required this.addressList,
  }) : super(key: key);

  final List<Address> addressList;

  @override
  Widget build(BuildContext context) {
    final addressCount = addressList.length;

    return Scaffold(
      key: const ValueKey("2"),
      bottomNavigationBar: const _BottomBar(),
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: Padding(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Obx(
              () => _CustomTile(
                address: addressList[index],
                groupValue: controller.selectedAddress,
                value: index,
                onAddressChange: controller.onAddressChanged,
              ).p8(),
            );
          },
          itemCount: addressCount,
        ),
        padding: const EdgeInsets.only(top: 10),
      ),
    );
  }
}

class _EmptyBody extends GetView<SelectAddressController> {
  const _EmptyBody({
    Key? key,
    required this.isAddressEmpty,
  }) : super(key: key);

  final bool isAddressEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("1"),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onAddAddress,
        child: const Icon(Icons.add_rounded, color: Vx.white, size: 35),
      ),
      bottomNavigationBar: kEmptyWidget,
      appBar: AppBar(
        title: const Text('Select Address'),
      ),
      body: SizedBox(
        height: 65,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: "No Addresses Saved!"
                .text
                .size(16)
                .make()
                .box
                .py12
                .px8
                .makeCentered(),
          ),
        ),
      ),
    );
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    Key? key,
    required this.value,
    this.onAddressChange,
    required this.address,
    required this.groupValue,
  }) : super(key: key);

  final Address address;
  final int value;
  final int? groupValue;
  final ValueChanged<int?>? onAddressChange;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return RadioListTile<int?>(
      value: value,
      selected: isSelected,
      tileColor: Vx.white,
      activeColor: primaryColor(context),
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
      child: address.toString().text.size(16).make(),
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
            .bold
            .make()
            .box
            .padding(const EdgeInsets.symmetric(horizontal: 24, vertical: 16))
            .roundedLg
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
    return Price(price: controller.totalPrice);
  }
}
