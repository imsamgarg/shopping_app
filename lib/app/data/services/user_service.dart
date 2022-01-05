import 'package:get/get.dart';

import 'package:shopping_app/app/core/values/db_strings.dart';
import 'package:shopping_app/app/data/models/user_model.dart';
import 'package:shopping_app/app/data/repository/database_repository.dart';
import 'package:shopping_app/app/data/repository/user_repository.dart';

class UserService extends GetxService {
  late final _userRepo = FirebaseUserRepository();
  late final _dbRepo = FirebaseDbRepository();
  String get uid => _userRepo.uid;

  UserModel? _user;

  UserModel get user => _user!;

  String get userName => _userRepo.userName;
  String get phoneNumber => _userRepo.phoneNumber;
  String? get profileUrl => _userRepo.profileUrl;
  bool get hasGoogleProvider => _userRepo.hasGoogleProvider;
  bool get hasMailProvider => _userRepo.hasMailProvider;
  bool get hasPhoneProvider => _userRepo.hasPhoneProvider;

  Future<String>? get token => _userRepo.token;

  String get mailAddress => _userRepo.mailAddress;
  String get googleMailAddress => _userRepo.googleEmail;

  static UserService service() => Get.find<UserService>();

  Future<bool> isUserSignedIn() => _userRepo.isUserLogged();

  Future<UserService> initUser() async {
    if (_user != null) {
      return this;
    }

    _user = await _getUserData();
    return this;
  }

  Future<UserModel> _getUserData() async {
    final doc = await _dbRepo.getDocumentFromFirestore(uid, Db.usersCol);
    return UserModel.fromJson(doc);
  }

  Future updateUsername(String name) async {
    return await _userRepo.updateName(name);
  }
}
