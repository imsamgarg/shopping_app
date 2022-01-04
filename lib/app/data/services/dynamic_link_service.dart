import 'package:flutter/widgets.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

import 'package:shopping_app/app/core/utils/mixins/error_handling_mixin.dart';
import 'package:shopping_app/app/core/utils/mixins/routes_mixin.dart';
import 'package:shopping_app/app/data/models/dynamic_link_model.dart';

class DynamicLinkService extends GetxService
    with WidgetsBindingObserver, RoutesMixin, ErrorHandlingMixin {
  static DynamicLinkService service() => Get.find<DynamicLinkService>();
  late final _instance = FirebaseDynamicLinks.instance;
  DynamicLink? link;

  @override
  void onInit() {
    WidgetsBinding.instance!.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      digestError(_handleLink);
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> saveInitialLink() async {
    await digestError(_saveInitialLink);
  }

  Future<void> _saveInitialLink() async {
    final linkData = await _instance.getInitialLink();
    link = linkData != null
        ? DynamicLink.fromJson(linkData.link.queryParameters)
        : null;
  }

  bool _shouldCheckForLink() {
    //TODO: implement krna eh
    return true;
  }

  void _handleLink() => _instance.onLink.first.then(_extractLink);

  Future<dynamic> _extractLink(PendingDynamicLinkData? linkData) async {
    if (!_shouldCheckForLink()) return;
    if (linkData != null) {
      final _link = DynamicLink.fromJson(linkData.link.queryParameters);
      link = _link;
      handleLink(link);
    }
  }

  void handleDynamicLink() {
    handleLink(link);
  }
}
