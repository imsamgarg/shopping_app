import 'package:shopping_app/app/data/models/dynamic_link_model.dart';

import 'category_model.dart';

class AppModel {
  DeliveryConfiguration? deliveryConfig;
  List<AppBanner>? banners;
  List<Category>? categories;
  List<SubCategory>? subCategories;

  AppModel({
    this.deliveryConfig,
    this.banners,
    this.categories,
    this.subCategories,
  });

  AppModel.fromJson(dynamic json) {
    deliveryConfig = DeliveryConfiguration.fromJson(json['deliveryConfig']);

    banners = (json['banners'] as List?)?.map((e) {
      return AppBanner.fromJson(e);
    }).toList();

    categories = (json['categories'] as List?)?.map((e) {
      return Category.fromJson(e);
    }).toList();

    subCategories = (json['subCategories'] as List?)?.map((e) {
      return SubCategory.fromJson(e);
    }).toList();
  }
}

class DeliveryConfiguration {
  int? codCharges;
  int? codFreeOn;
  String? playLink;
  bool? isCodAvailable;
  late bool isRazorPayAvailable;
  int? razorPayCharges;
  int? razorPayFreeOn;
  String? razorPayKey;

  DeliveryConfiguration({
    this.codCharges,
    this.codFreeOn,
    this.playLink,
    this.isCodAvailable,
    this.isRazorPayAvailable = false,
    this.razorPayCharges,
    this.razorPayFreeOn,
    this.razorPayKey,
  });

  DeliveryConfiguration.fromJson(dynamic json) {
    isCodAvailable = json['isCodAvailable'];
    isRazorPayAvailable = json['isRazorPayAvailable'] ?? false;
    razorPayCharges = json['razorPayCharges'];
    razorPayFreeOn = json['razorPayFreeOn'];
    razorPayKey = json['razorPayKey'];
    codCharges = json['codCharges'];
    codFreeOn = json['codFreeOn'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codCharges'] = codCharges;
    data['codFreeOn'] = codFreeOn;
    data['isCodAvailable'] = isCodAvailable;
    data['isRazorPayAvailable'] = isRazorPayAvailable;
    data['razorPayCharges'] = razorPayCharges;
    data['razorPayFreeOn'] = razorPayFreeOn;
    data['razorPayKey'] = razorPayKey;
    return data;
  }
}

class AppBanner {
  String? id;
  String? image;
  String? type;
  AppBanner({this.id, this.image, this.type});

  AppBanner.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    type = json['type'];
  }

  dynamic toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['type'] = type;

    return data;
  }

  DynamicLink toDynamicLink() {
    return DynamicLink.fromJson({
      "id": id,
      "type": type,
    });
  }
}
