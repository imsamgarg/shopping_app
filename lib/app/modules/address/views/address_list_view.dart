import 'package:flutter/material.dart';

import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/app_bar.dart';
import 'package:shopping_app/app/core/global_widgets/future_builder.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/modules/address/controllers/address_list_controller.dart';

class AddressListView extends GetView<AddressListController> {
  @override
  Widget build(BuildContext context) {
    return AppFutureBuilder(
      future: controller.instance,
      builder: (_) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: controller.onAddAddressTap,
            child: const Icon(
              Icons.add_rounded,
              color: Vx.white,
              size: 35,
            ),
          ),
          body: GetBuilder<AddressListController>(
            init: controller,
            builder: (_) {
              final addressCount = controller.addresses.length;
              return CustomScrollView(
                slivers: [
                  SliverAppBarWithCartIcon(
                    ("Address List"),
                    color: primaryColor(context),
                  ),
                  if (addressCount != 0) ...[
                    verSliverSpacing10,
                    SliverToBoxAdapter(
                      child: "Swipe To Edit Or Delete"
                          .text
                          .color(ColorTheme.textColor)
                          .makeCentered(),
                    ),
                    verSliverSpacing10,
                  ],
                  if (addressCount == 0)
                    SliverToBoxAdapter(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: "No Addresses Saved! Please Add One"
                              .text
                              .size(16)
                              .make()
                              .box
                              .py12
                              .make(),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) {
                            return AddressCard(index: index);
                          },
                          childCount: addressCount,
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 10),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class AddressCard extends GetView<AddressListController> {
  const AddressCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final address = controller.addresses[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: ValueKey("$index$address"),
        child: Card(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: address.toString().text.size(16).make(),
            ),
          ),
        ),
        endActionPane: _actionPane(),
        startActionPane: _actionPane(),
      ),
    );
  }

  ActionPane _actionPane() {
    return ActionPane(
      motion: const DrawerMotion(),
      children: [
        SlidableAction(
          onPressed: (_) => controller.editAddress(index),
          label: "Edit",
          icon: Icons.edit_rounded,
          backgroundColor: ColorTheme.primarySwatch[50]!,
          foregroundColor: ColorTheme.primaryColor,
        ),
        SlidableAction(
          onPressed: (_) => controller.deleteAddress(index),
          label: "Delete",
          icon: Icons.delete_rounded,
          foregroundColor: Vx.white,
          backgroundColor: ColorTheme.primaryColor,
        ),
      ],
    );
  }
}
