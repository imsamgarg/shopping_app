class SubCategory {
  String? name;
  String? category;
  String? image;

  SubCategory({this.name, this.image});

  SubCategory.fromJson(dynamic json) {
    name = json['name'];
    category = json['category'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['image'] = image;
    return data;
  }
}

class Category {
  String? name;
  String? img;

  Category({this.name, this.img});

  Category.fromJson(dynamic json) {
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
