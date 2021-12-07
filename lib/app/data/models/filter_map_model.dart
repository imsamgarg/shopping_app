class FilterMap {
  int? minPrice;
  int? maxPrice;
  List<String>? size;
  List<String>? color;

  FilterMap({this.minPrice, this.maxPrice, this.size, this.color});

  FilterMap.fromJson(Map<String, dynamic> json) {
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    size = json['size'].cast<String>();
    color = json['color'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['minPrice'] = minPrice;
    data['maxPrice'] = maxPrice;
    data['size'] = size;
    data['color'] = color;
    return data;
  }
}
