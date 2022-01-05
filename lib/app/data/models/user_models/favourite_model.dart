import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteModel {
  String? id;
  Timestamp? time;

  FavouriteModel({this.id, this.time});

  FavouriteModel.fromJson(dynamic json) {
    id = json['id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[id!] = time;
    return data;
  }
}
