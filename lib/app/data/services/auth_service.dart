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

  Future<void> signInWithEmail(String email, String pass) {
    return _repo.signInWithEmail(email, pass);
  }

  Future<bool> signInWithGoogle() {
    return _repo.signInWithGoogle();
  }

  Future<bool> loginWithPhone(AuthCredential credential) {
    return _repo.loginWithPhoneCreds(credential);
  }

  Future<void> initPhoneAuth({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 30),
    int? forceResendingToken,
  }) {
    return _repo.loginWithPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: timeout,
      forceResendingToken: forceResendingToken,
    );
  }

  Future sendPassResetEmail(String email) {
    return _repo.sendPassResetEmail(email);
  }

  Future linkWithCreds(AuthCredential credential) {
    return _repo.linkWithCreds(credential);
  }
}
