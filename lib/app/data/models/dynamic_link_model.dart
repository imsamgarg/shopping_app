import 'package:shopping_app/app/core/values/values.dart';

class DynamicLink {
  static const _product = "product";
  static const _offer = "ofer";
  static const _order = "order";
  static const _category = "category";

  String? id;
  String? type;
  DynamicLinkType? linkType;

  DynamicLink({this.id, this.linkType, this.type});

  DynamicLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['linkType'];

    if (type == null) {
      return;
    }

    if (type == _product) {
      linkType = DynamicLinkType.product;
    } else if (type == _offer) {
      linkType = DynamicLinkType.offer;
    } else if (type == _order) {
      linkType = DynamicLinkType.order;
    } else if (type == _category) {
      linkType = DynamicLinkType.subCategory;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['linkType'] = linkType;
    return data;
  }
}
