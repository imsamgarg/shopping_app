class AppModel {
  Config? config;
  List<Offer>? offers;
  List<Category>? categories;

  AppModel({this.config, this.offers, this.categories});

  AppModel.fromJson(json) {
    config = json['config'] != null ? Config?.fromJson(json['config']) : null;
    if (json['offers'] != null) {
      offers = <Offer>[];
      json['offers']?.forEach((v) {
        offers?.add(Offer.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories']?.forEach((v) {
        categories?.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (config != null) {
      data['config'] = config?.toJson();
    }
    if (offers != null) {
      data['offers'] = offers?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Config {
  List<String>? sizeCharts;
  List<String>? returnPolicy;
  int? codCharges;
  int? codFreeOn;
  String? fbLink;
  String? instaLink;
  String? playLink;
  bool? isCodAvailable;
  bool? isRazorPayAvailable;
  int? razorPayCharges;
  int? razorPayFreeOn;
  String? razorPayKey;
  String? waLink;
  List<String>? emailAddress;
  List<String>? phoneNumber;
  String? description;

  Config(
      {this.sizeCharts,
      this.returnPolicy,
      this.codCharges,
      this.codFreeOn,
      this.fbLink,
      this.instaLink,
      this.playLink,
      this.isCodAvailable,
      this.isRazorPayAvailable,
      this.razorPayCharges,
      this.razorPayFreeOn,
      this.razorPayKey,
      this.waLink,
      this.emailAddress,
      this.phoneNumber,
      this.description});

  Config.fromJson(dynamic json) {
    sizeCharts = json['sizeCharts']?.cast<String>();
    returnPolicy = json['returnPolicy']?.cast<String>();
    codCharges = json['codCharges'];
    codFreeOn = json['codFreeOn'];
    fbLink = json['fbLink'];
    instaLink = json['instaLink'];
    playLink = json['playLink'];
    isCodAvailable = json['isCodAvailable'];
    isRazorPayAvailable = json['isRazorPayAvailable'];
    razorPayCharges = json['razorPayCharges'];
    razorPayFreeOn = json['razorPayFreeOn'];
    razorPayKey = json['razorPayKey'];
    waLink = json['waLink'];
    emailAddress = json['emailAddress']?.cast<String>();
    phoneNumber = json['phoneNumber']?.cast<String>();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sizeCharts'] = sizeCharts;
    data['returnPolicy'] = returnPolicy;
    data['codCharges'] = codCharges;
    data['codFreeOn'] = codFreeOn;
    data['fbLink'] = fbLink;
    data['instaLink'] = instaLink;
    data['playLink'] = playLink;
    data['isCodAvailable'] = isCodAvailable;
    data['isRazorPayAvailable'] = isRazorPayAvailable;
    data['razorPayCharges'] = razorPayCharges;
    data['razorPayFreeOn'] = razorPayFreeOn;
    data['razorPayKey'] = razorPayKey;
    data['waLink'] = waLink;
    data['emailAddress'] = emailAddress;
    data['phoneNumber'] = phoneNumber;
    data['description'] = description;
    return data;
  }
}

class Offer {
  String? id;
  String? img;
  bool? isProduct;

  Offer({this.id, this.img, this.isProduct});

  Offer.fromJson(dynamic json) {
    id = json['id'];
    img = json['img'];
    isProduct = json['isProduct'];
  }

  dynamic toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['img'] = img;
    data['isProduct'] = isProduct;
    return data;
  }
}

class Category {
  String? name;
  String? img;
  List<SubCat>? subCats;

  Category({this.name, this.img, this.subCats});

  Category.fromJson(dynamic json) {
    name = json['name'];
    img = json['img'];
    if (json['subCats'] != null) {
      subCats = <SubCat>[];
      json['subCats']?.forEach((v) {
        subCats?.add(SubCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    if (subCats != null) {
      data['subCats'] = subCats?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCat {
  String? name;
  String? img;

  SubCat({this.name, this.img});

  SubCat.fromJson(dynamic json) {
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    return data;
  }
}
