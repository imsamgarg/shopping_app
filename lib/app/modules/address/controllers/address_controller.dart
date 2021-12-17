import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/validator_mixin.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/modules/address/controllers/address_list_controller.dart';

class AddressController extends GetxController
    with ServicesMixin, ValidatorMixin {
  int? index;

  bool isButtonLoading = false;
  final String buttonId = "button";

  AddressController(this.index);

  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController alternativeController;
  late TextEditingController localityController;
  late TextEditingController houseStreetController;
  late TextEditingController pinCodeController;
  late TextEditingController cityController;

  late GlobalKey<FormState> formKey = GlobalKey();

  String? state;

  @override
  void onInit() {
    Address address;
    if (index != null) {
      address = userService.user.address![index!];
    } else {
      address = Address();
    }
    nameController = TextEditingController(text: address.name);
    mobileNumberController = TextEditingController(text: address.mobileNumber);
    alternativeController = TextEditingController(
      text: address.alternativeNumber,
    );
    localityController = TextEditingController(text: address.locality);
    houseStreetController = TextEditingController(text: address.houseStreet);
    pinCodeController = TextEditingController(
      text: address.pinCode?.toString(),
    );
    cityController = TextEditingController(text: address.city);
    state = address.state;
    super.onInit();
  }

  void stateChanged(String? value) {
    state = value;
  }

  void saveAddress() async {
    if (!formKey.currentState!.validate()) return;
    final shouldSave = index == null;
    toggleLoading(true);
    Address _address = Address(
      city: cityController.text,
      alternativeNumber: alternativeController.text,
      houseStreet: houseStreetController.text,
      locality: localityController.text,
      mobileNumber: mobileNumberController.text,
      name: nameController.text,
      pinCode: int.parse(pinCodeController.text),
      state: state!,
    );
    if (shouldSave) {
      await userService.addAddress(_address);
    } else {
      await userService.updateAddress(_address, index!);
    }
    Get.find<AddressListController>().updateData();
    successSnackbar("Address Saved");
    if (!shouldSave) return goBack();
    reset();
    toggleLoading(false);
  }

  void reset() => formKey.currentState!.reset();

  String? pinCodeValidator(String? value) {
    value ??= "";
    value = value.removeAllWhitespace;
    if (!value.isNumericOnly) return "Invalid Pincode";
    if (value.isEmpty) return "Please Enter Value";
    if (value.length != 6) {
      return "Invalid Pincode";
    }
  }

  void toggleLoading(bool value) {
    isButtonLoading = value;
    update([buttonId]);
  }
}
