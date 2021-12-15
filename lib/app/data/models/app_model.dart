class AppModel {
  Config? config;
  late List<AppBanner> banners;
  late List<Category> categories;

  AppModel({this.config, required this.banners, required this.categories});

  AppModel.fromJson(json) {
    config = json['config'] != null ? Config?.fromJson(json['config']) : null;
    if (json['offers'] != null) {
      banners = <AppBanner>[];
      json['offers']?.forEach((v) {
        banners.add(AppBanner.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories']?.forEach((v) {
        categories.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (config != null) {
      data['config'] = config?.toJson();
    }
    data['offers'] = banners.map((v) => v.toJson()).toList();
    data['categories'] = categories.map((v) => v.toJson()).toList();
    return data;
  }
}

class Config {
  late List<String> sizeCharts;
  late List<String> returnPolicy;
  int? codCharges;
  int? codFreeOn;
  late String? fbLink;
  late String? instaLink;
  String? playLink;
  bool? isCodAvailable;
  late bool isRazorPayAvailable;
  int? razorPayCharges;
  int? razorPayFreeOn;
  String? razorPayKey;
  late String? waLink;
  late List<String> emailAddress;
  late List<String> phoneNumber;
  String? description;

  Config(
      {required this.sizeCharts,
      required this.returnPolicy,
      this.codCharges,
      this.codFreeOn,
      this.fbLink,
      this.instaLink,
      this.playLink,
      this.isCodAvailable,
      this.isRazorPayAvailable = false,
      this.razorPayCharges,
      this.razorPayFreeOn,
      this.razorPayKey,
      this.waLink,
      required this.emailAddress,
      required this.phoneNumber,
      this.description});

  Config.fromJson(dynamic json) {
    sizeCharts = json['sizeCharts']?.cast<String>() ?? [];
    returnPolicy = json['returnPolicy']?.cast<String>() ?? [];
    codCharges = json['codCharges'];
    codFreeOn = json['codFreeOn'];
    fbLink = json['fbLink'] ??
        "https://www.facebook.com/fashion24x7coin-111679071026537/";
    instaLink = json['instaLink'] ??
        "https://instagram.com/invites/contact/?i=gyqos9lhrrpk&utm_content=3ujt000";
    playLink = json['playLink'];
    isCodAvailable = json['isCodAvailable'];
    isRazorPayAvailable = json['isRazorPayAvailable'] ?? false;
    razorPayCharges = json['razorPayCharges'];
    razorPayFreeOn = json['razorPayFreeOn'];
    razorPayKey = json['razorPayKey'];
    waLink = json['waLink'] ?? "https://wa.me/message/BYXC6AYL3AGSG1";
    emailAddress =
        json['emailAddress']?.cast<String>() ?? ["Thenewfashion24.7@gmail.com"];
    phoneNumber = json['phoneNumber']?.cast<String>() ?? ["9878502440"];
    description = json['description'] ??
        '''Make your home elegant and composed with our wide range of curtains, custom picked by our architects and interior designers from Australia to suit your taste and fit perfectly in your home. Our team has over 35years experience in curtains and blinds.We are here to assist you to get your picture perfect home.''';
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

class AppBanner {
  String? id;
  String? img;
  bool? isProduct;

  AppBanner({this.id, this.img, this.isProduct});

  AppBanner.fromJson(dynamic json) {
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
