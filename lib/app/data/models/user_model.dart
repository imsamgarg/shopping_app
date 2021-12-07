import 'cart_model.dart';

class UserModel {
  late Map<String, DateTime> favourites;
  late Map<String, CartModel> cartItems;
  List<Address>? address;
  List<String>? savedList;

  UserModel({required this.favourites, required this.cartItems, this.address});

  UserModel.fromJson(Map<String, dynamic> json) {
    json['cart'] != null
        ? cartItems = (json['cart'] as Map).map(
            (key, value) => MapEntry(key as String, CartModel.fromJson(value)),
          )
        : {};

    json['favourite'] != null
        ? favourites = (json['favourite'] as Map).map(
            (key, value) => MapEntry(
              key as String,
              DateTime.fromMillisecondsSinceEpoch(value),
            ),
          )
        : {};
    savedList = favourites.entries.map((e) => e.key).toList();

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
    required this.city,
    required this.houseStreet,
    required this.locality,
    required this.mobileNumber,
    required this.name,
    required this.pinCode,
    required this.state,
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
