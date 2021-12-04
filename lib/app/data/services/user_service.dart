import 'package:get/get.dart';
import 'package:shopping_app/app/data/repository/user_repository.dart';

class UserService extends GetxService {
  static UserService service() => Get.find<UserService>();
  late final _repo = FirebaseUserRepository();

  String get userName => _repo.userName;
  String get phoneNumber => _repo.phoneNumber;
  String? get profileUrl => _repo.profileUrl;
  String get uid => _repo.uid;
  Future<String>? get token => _repo.token;

  Future<bool> isUserSignedIn() => _repo.isUserLogged();
}
