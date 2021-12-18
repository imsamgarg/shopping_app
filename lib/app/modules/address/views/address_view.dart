import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';
import 'package:shopping_app/app/modules/address/controllers/address_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressView extends StatelessWidget {
  final int? index;

  const AddressView({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(index == null ? "Add Address" : "Edit Address"),
          ),
          SliverToBoxAdapter(
            child: _Form(
              index: index,
            ),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatelessWidget {
  late final controller = Get.put(AddressController(index));
  final int? index;

  _Form({
    Key? key,
    this.index,
  }) : super(key: key);

  final _stateList = {
    "Andaman and Nicobar Islands",
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chandigarh",
    "Chhattisgarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Lakshadweep",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Pondicherry",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Tripura",
    "Uttaranchal",
    "Uttar Pradesh",
    "West Bengal"
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: Sizing.sidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verSpacing10,
            TextFormField(
              controller: controller.nameController,
              validator: controller.nameValidator,
              // initialValue: address==null?"":address.name ?? "",
              decoration: textDecoration(context,
                  icon: Icons.person, hint: "Full Name"),
            ),
            verSpacing10,
            TextFormField(
              controller: controller.mobileNumberController,
              validator: controller.phoneNumberValidator,
              keyboardType: TextInputType.number,
              maxLength: 11,
              // initialValue: address==null?"":address.mobileNumber ?? "",
              decoration: textDecoration(context,
                  icon: Icons.phone, hint: "Mobile Number"),
            ),
            verSpacing10,
            TextFormField(
              validator: controller.phoneNumberValidator,
              controller: controller.alternativeController,
              keyboardType: TextInputType.number,
              maxLength: 11,

              // initialValue: address==null?"":address.alternativeNumber ?? "",
              decoration: textDecoration(context,
                  icon: Icons.phone, hint: "Alternative Mobile Number"),
            ),
            verSpacing10,
            TextFormField(
              validator: controller.requiredValidator,
              controller: controller.localityController,
              maxLines: 4,
              minLines: 1,
              // initialValue: address==null?"":address.locality ?? "",
              decoration: textDecoration(context,
                  icon: Icons.home_rounded, hint: "Building/Flat/House No."),
            ),
            verSpacing10,
            TextFormField(
              maxLines: 4,
              minLines: 1,
              validator: controller.requiredValidator,
              controller: controller.houseStreetController,
              // initialValue: address==null?"":address.houseStreet ?? "",
              decoration: textDecoration(context,
                  icon: Icons.home_work_rounded, hint: "Street Locality"),
            ),
            verSpacing10,
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    validator: controller.pinCodeValidator,
                    controller: controller.pinCodeController,
                    maxLength: 6,
                    // initialValue: address==null?"":address.pinCode ?? "",
                    keyboardType: TextInputType.number,
                    decoration: textDecoration(context,
                        icon: Icons.code_rounded, hint: "Pin Code"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextFormField(
                    validator: controller.nameValidator,
                    controller: controller.cityController,
                    // initialValue: address==null?"":address.city ?? "",
                    decoration: textDecoration(context,
                        icon: Icons.location_city_rounded, hint: "City"),
                  ),
                ),
              ],
            ),
            verSpacing10,
            DropdownButtonFormField(
              onChanged: controller.stateChanged,
              validator: controller.requiredValidator,
              value: controller.state,
              decoration: textDecoration(context,
                  hint: "State", icon: Icons.location_pin),
              items: _stateList
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(growable: false),
            ),
            verSpacing30,
            GetBuilder<AddressController>(
              init: controller,
              id: controller.buttonId,
              builder: (_) {
                return AppTextButton(
                  onTap: controller.saveAddress,
                  isLoading: controller.isButtonLoading,
                  child: Text(index == null ? "Save" : "Edit"),
                );
              },
            ),
            verSpacing20,
            AppOutlinedButton(
              onTap: controller.reset,
              child: Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration textDecoration(
  BuildContext context, {
  String hint = "",
  IconData? icon,
}) {
  return InputDecoration(
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: Sizing.borderRadiusM,
      borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: ColorTheme.primaryColor.withOpacity(
          0.2,
        ),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: Sizing.borderRadiusM,
      borderSide: BorderSide.none,
    ),
    fillColor: Vx.white,
    focusColor: Vx.white,
    hintText: hint,
    counterText: "",
    hintMaxLines: null,
    prefixIcon: Icon(
      icon,
    ),
  );
}
