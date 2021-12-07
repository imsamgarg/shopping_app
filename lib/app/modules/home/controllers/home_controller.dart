import 'package:get/get.dart';

class HomeController extends GetxController {
  final _index = 0.obs;
  get index => _index.value;
  set index(value) => _index.value = value;

  void onIndexChange(int p1) {
    index = p1;
  }
}
