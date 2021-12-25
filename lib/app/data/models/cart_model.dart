import 'package:shopping_app/app/data/models/product_model.dart';

class CartModel {
  int? fullPrice;
  late int quantity;
  ProductModel? product;
  String? color;
  String? size;

  CartModel({
    this.fullPrice,
    this.quantity = 1,
    this.product,
    this.color,
    this.size,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    fullPrice = json['fullPrice'];
    quantity = json['quantity'] ?? 1;
    product = json['product'] != null
        ? ProductModel?.fromJson(json['product'])
        : null;
    color = json['color'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fullPrice'] = fullPrice;
    data['quantity'] = quantity;
    if (product != null) {
      data['product'] = product?.toJson();
    }
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}
