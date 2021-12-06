import 'package:shopping_app/app/data/models/product_model.dart';

class CartModel {
  int? fullPrice;
  int? quantity;
  ProductModel? product;
  List<int>? options;

  CartModel({this.fullPrice, this.quantity, this.product, this.options});

  CartModel.fromJson(json) {
    fullPrice = json['fullPrice'];
    quantity = json['quantity'];
    product = json['product'] != null
        ? ProductModel?.fromJson(json['product'])
        : null;
    options = json['options'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fullPrice'] = fullPrice;
    data['quantity'] = quantity;
    if (product != null) {
      data['product'] = product?.toJson();
    }
    data['options'] = options;
    return data;
  }
}
