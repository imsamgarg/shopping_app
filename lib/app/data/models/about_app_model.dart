class AboutAppModel {
  late List<String> returnPolicy;
  late String? waLink;
  late List<String> emailAddress;
  late List<String> phoneNumber;
  late String? fbLink;
  late String? instaLink;
  String? description;

  AboutAppModel({
    required this.returnPolicy,
    this.fbLink,
    this.instaLink,
    required this.emailAddress,
    this.description,
    this.waLink,
    required this.phoneNumber,
  });

  AboutAppModel.fromJson(dynamic json) {
    returnPolicy = json['returnPolicy']?.cast<String>() ?? [];
    fbLink = json['fbLink'] ??
        "https://www.facebook.com/fashion24x7coin-111679071026537/";
    instaLink = json['instaLink'] ??
        "https://instagram.com/invites/contact/?i=gyqos9lhrrpk&utm_content=3ujt000";

    waLink = json['waLink'] ?? "https://wa.me/message/BYXC6AYL3AGSG1";
    emailAddress =
        json['emailAddress']?.cast<String>() ?? ["Thenewfashion24.7@gmail.com"];
    phoneNumber = json['phoneNumber']?.cast<String>() ?? ["9878502440"];
    description = json['description'] ??
        '''Make your home elegant and composed with our wide range of curtains, custom picked by our architects and interior designers from Australia to suit your taste and fit perfectly in your home. Our team has over 35years experience in curtains and blinds.We are here to assist you to get your picture perfect home.''';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['returnPolicy'] = returnPolicy;
    data['fbLink'] = fbLink;
    data['instaLink'] = instaLink;
    data['waLink'] = waLink;
    data['emailAddress'] = emailAddress;
    data['phoneNumber'] = phoneNumber;
    data['description'] = description;
    return data;
  }
}
