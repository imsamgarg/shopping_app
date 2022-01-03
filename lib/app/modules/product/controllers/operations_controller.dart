import 'package:get/get.dart';

class OperationsController extends GetxController {
  //TODO: Implement OperationsController

  final count = 0.obs;

  @override
  void onClose() {}
  void increment() => count.value++;
}
