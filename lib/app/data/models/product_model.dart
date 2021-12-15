import 'package:cloud_firestore/cloud_firestore.dart';

class ProductSnapshot {
  final ProductModel product;
  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;
  ProductSnapshot(this.product, this.snapshot);
}

class ProductModel {
  String? id;
  String? name;
  String? category;
  String? subCategory;
  String? description;
  String? link;
  int? price;
  int? discount;
  int? popularity;
  int? returnDays;
  int? sizechart;
  bool? isPopular;
  bool? isReturnable;
  List<String>? img;
  List<String>? tags;
  List<String>? features;
  bool? isSizeRequired;
  bool? isColorRequired;
  String? selectedSize;
  String? selectedColor;
  Map<String, int>? size;
  Map<String, Color>? color;

  ProductModel({
    this.id,
    this.name,
    this.category,
    this.subCategory,
    this.description,
    this.link,
    this.price,
    this.discount,
    this.popularity,
    this.returnDays,
    this.sizechart,
    this.isPopular,
    this.isReturnable,
    this.img,
    this.tags,
    this.features,
    this.isSizeRequired,
    this.isColorRequired,
    this.selectedSize,
    this.selectedColor,
    this.size,
    this.color,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    subCategory = json['subCategory'];
    description = json['description'];
    link = json['link'];
    price = json['price'];
    discount = json['discount'];
    popularity = json['popularity'];
    returnDays = json['returnDays'];
    sizechart = json['sizechart'];
    isPopular = json['isPopular'];
    isReturnable = json['isReturnable'];
    img = json['img']?.cast<String>();
    tags = json['tags']?.cast<String>();
    features = json['features']?.cast<String>();
    isSizeRequired = json['isSizeRequired'];
    isColorRequired = json['isColorRequired'];
    selectedSize = json['selectedSize'];
    selectedColor = json['selectedColor'];
    size = json['size'] != null
        ? (json['size'] as Map).map((k, v) => MapEntry(k, v))
        : null;
    color = json['color'] != null
        ? (json['color'] as Map).map((k, v) => MapEntry(k, Color.fromJson(v)))
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['description'] = description;
    data['link'] = link;
    data['price'] = price;
    data['discount'] = discount;
    data['popularity'] = popularity;
    data['returnDays'] = returnDays;
    data['sizechart'] = sizechart;
    data['isPopular'] = isPopular;
    data['isReturnable'] = isReturnable;
    data['img'] = img;
    data['tags'] = tags;
    data['features'] = features;
    data['isSizeRequired'] = isSizeRequired;
    data['isColorRequired'] = isColorRequired;
    data['selectedSize'] = selectedSize;
    data['selectedColor'] = selectedColor;
    if (size != null) {
      data['size'] = size?.toString();
    }
    if (color != null) {
      data['color'] = color?.toString();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Size {
  int? sizeName;

  Size({this.sizeName});

  Size.fromJson(Map<String, dynamic> json) {
    sizeName = json['sizeName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sizeName'] = sizeName;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Color {
  int? priceDifferce;
  String? img;

  Color({this.priceDifferce, this.img});

  Color.fromJson(Map<String, dynamic> json) {
    priceDifferce = json['priceDifferce'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['priceDifferce'] = priceDifferce;
    data['img'] = img;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
