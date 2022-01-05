class Address {
  String? id;
  String? alternativeNumber;
  String? city;
  String? houseStreet;
  String? locality;
  String? mobileNumber;
  String? name;
  int? pinCode;
  String? state;

  Address({
    this.id,
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
    id = json['id'];
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
