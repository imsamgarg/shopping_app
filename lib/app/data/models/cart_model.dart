import 'package:shopping_app/app/data/models/product_model.dart';

class CheckoutModel {
  final List<CartModel> cartItems;
  final int totalPrice;

  CheckoutModel({required this.cartItems, required this.totalPrice});
}

class CartModel {
  int? fullPrice;
  String? size;
  String? color;

  //no change in database
  late int quantity;

  //for frontend
  bool? inStock;
  bool? isColorInStock;
  bool? isSizeInStock;
  ProductModel? product;

  CartModel({
    this.fullPrice,
    this.quantity = 1,
    this.product,
    this.color,
    this.size,
    this.inStock,
    this.isColorInStock,
    this.isSizeInStock,
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
    // data['fullPrice'] = fullPrice;
    data['quantity'] = quantity;
    // if (product != null) {
    //   data['product'] = product?.toJson();
    // }
    data['color'] = color;
    data['size'] = size;
    return data;
  }
}
