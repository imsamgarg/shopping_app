class Cart {
  int? fullPrice;
  int? quantity;
  Product? product;
  List<int>? options;

  Cart({this.fullPrice, this.quantity, this.product, this.options});

  Cart.fromJson(Map<String, dynamic> json) {
    fullPrice = json['fullPrice'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? Product?.fromJson(json['product']) : null;
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
