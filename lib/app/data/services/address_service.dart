import 'package:get/get.dart';
import 'package:shopping_app/app/core/utils/mixins/services_mixin.dart';
import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/user_models/address_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';

class AddressService extends GetxService with ServicesMixin {
  List<Address>? addressList;

  late final _dbRepo = FirebaseDbRepository();
  late final userId = userService.uid;

  Future<AddressService> initService() async {
    if (addressList != null) {
      return this;
    }

    addressList = await _getAddresses();
    return this;
  }

  Future<List<Address>> _getAddresses() async {
    final snapshots = await _dbRepo.getAllSubCollectionDocuments(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.addressSubCol,
    );

    return snapshots.docs.map((e) {
      final address = Address.fromJson(e.data());
      address.id = e.id;
      return address;
    }).toList();
  }

  Future addAddress(Address address) async {
    final data = address.toJson();

    final snapshot = await _dbRepo.addSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.addressSubCol,
      data: data,
    );

    address.id = snapshot.id;

    addressList?.add(address);
  }

  Future updateAddress(Address address, int index) async {
    final address = addressList?[index];

    final data = address?.toJson();

    await _dbRepo.updateSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.addressSubCol,
      subColDocId: address!.id!,
      data: data!,
    );

    addressList?.add(address);
  }

  Future delAddress(int index) async {
    final address = addressList?[index];

    await _dbRepo.deleteSubCollectionDocument(
      collection: Db.usersCol,
      documentId: userId,
      subCollection: Db.addressSubCol,
      subColDocId: address!.id!,
    );

    addressList?.removeAt(index);
  }
}
