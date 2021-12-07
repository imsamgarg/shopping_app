import 'package:shopping_app/app/data/models/product_model.dart';

class CartModel {
  int? fullPrice;
  int? quantity;
  ProductModel? product;
  String? color;
  String? size;

  CartModel(
      {this.fullPrice, this.quantity, this.product, this.color, this.size});

  CartModel.fromJson(Map<String, dynamic> json) {
    fullPrice = json['fullPrice'];
    quantity = json['quantity'];
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

class Product {
  String? fu;

  Product({this.fu});

  Product.fromJson(Map<String, dynamic> json) {
    fu = json['fu'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fu'] = fu;
    return data;
  }
}
