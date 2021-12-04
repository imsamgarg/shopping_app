import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shopping_app/app/core/utils/typedefs.dart';
import 'package:shopping_app/app/data/repository/user_repository.dart';

class AuthService extends GetxService {
  late final _repo = FirebaseUserRepository();

  static AuthService service() => Get.find<AuthService>();

  Future<void> registerWithEmail(
    String email,
    String password, {
    String? name,
  }) async {
    return _repo.signUpWithEmail(email, password, name: name);
  }

  Future<void> signInWitwhEmail(email, pass) {
    return _repo.signInWithEmail(email, pass);
  }

  Future<bool> signInWithGoogle() {
    return _repo.signInWithGoogle();
  }

  Future<bool> loginWithPhone(AuthCredential credential) {
    return _repo.loginWithPhoneCreds(credential);
  }

  PhoneAuthCallback get initPhoneAuth => _repo.loginWithPhoneNumber;
}
