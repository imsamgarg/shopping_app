import 'package:cloud_firestore/cloud_firestore.dart';

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
  List<Options>? options;

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
    this.options,
  });

  ProductModel.fromJson(json) {
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
    if (json['options'] != null) {
      options = <Options>[];
      json['options']?.forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
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
    if (options != null) {
      data['options'] = options?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is ProductModel && hashCode == other.hashCode;
  }

  @override
  int get hashCode => Object.hash(id, price);
}

class Options {
  bool? isRequired;
  String? name;
  int? selectedValue;
  bool? isDifferent;
  List<Values>? values;

  Options({
    this.isRequired,
    this.name,
    this.selectedValue,
    this.isDifferent,
    this.values,
  });

  Options.fromJson(json) {
    isRequired = json['isRequired'];
    name = json['name'];
    selectedValue = json['selectedValue'];
    isDifferent = json['isDifferent'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values']?.forEach((v) {
        values?.add(Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['isRequired'] = isRequired;
    data['name'] = name;
    data['selectedValue'] = selectedValue;
    data['isDifferent'] = isDifferent;
    if (values != null) {
      data['values'] = values?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  String? img;
  bool? inStock;
  String? name;
  int? priceDifference;

  Values({
    this.img,
    this.inStock,
    this.name,
    this.priceDifference,
  });

  Values.fromJson(json) {
    img = json['img'];
    inStock = json['inStock'];
    name = json['name'];
    priceDifference = json['priceDifference'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['img'] = img;
    data['inStock'] = inStock;
    data['name'] = name;
    data['priceDifference'] = priceDifference;
    return data;
  }
}

class ProductSnapshot {
  final ProductModel product;
  final QueryDocumentSnapshot<Map<String, dynamic>> snapshot;

  ProductSnapshot(this.product, this.snapshot);
}
