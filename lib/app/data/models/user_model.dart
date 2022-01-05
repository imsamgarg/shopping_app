import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_model.dart';

class UserModel {
  late Map<String, Timestamp> favourites;
  late Map<String, CartModel> cartItems;
  List<Address>? address;
  List<String>? orders;
  int? ordersCount;
  // List<String>? savedList;

  UserModel({required this.favourites, required this.cartItems, this.address});

  UserModel.fromJson(Map<String, dynamic> json) {
    cartItems = json['cart'] != null
        ? (json['cart'] as Map).map(
            (key, value) => MapEntry(key as String, CartModel.fromJson(value)),
          )
        : {};

    favourites = json['favourite'] != null
        ? (json['favourite'] as Map).map(
            (key, value) => MapEntry(
              key as String,
              value,
            ),
          )
        : {};
    // savedList = favourites.entries.map((e) => e.key).toList();
    ordersCount = json['ordersCount'];
    if (json['orders'] != null) {
      orders = (json['orders'] as List).cast<String>();
    }
    address = json['address'] != null
        ? (json['address'] as List).map((e) => Address.fromJson(e)).toList()
        : <Address>[];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['favourite'] = favourites.map(
      (key, value) => MapEntry(key, value.millisecondsSinceEpoch),
    );

    data['cart'] = cartItems.toString();

    data['address'] = address?.map((e) => e.toJson()).toList();

    return data;
  }
}

class Address {
  String? alternativeNumber;
  String? city;
  String? houseStreet;
  String? locality;
  String? mobileNumber;
  String? name;
  int? pinCode;
  String? state;

  Address({
    this.alternativeNumber,
    this.city,
    this.houseStreet,
    this.locality,
    this.mobileNumber,
    this.name,
    this.pinCode,
    this.state,
  });

  Address.fromJson(Map<String, dynamic> json) {
    alternativeNumber = json['alternativeNumber'];
    city = json['city'];
    houseStreet = json['houseStreet'];
    locality = json['locality'];
    mobileNumber = json['mobileNumber'];
    name = json['name'];
    pinCode = json['pinCode'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['alternativeNumber'] = alternativeNumber;
    data['city'] = city;
    data['houseStreet'] = houseStreet;
    data['locality'] = locality;
    data['mobileNumber'] = mobileNumber;
    data['name'] = name;
    data['pinCode'] = pinCode;
    data['state'] = state;
    return data;
  }

  @override
  String toString() {
    return "Name:$name\n"
        "Phone No:$mobileNumber , ${alternativeNumber ?? ""}\n"
        "Address:$houseStreet, $locality,$city,$state\n"
        "Pic Code:$pinCode";
  }
}
