import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shopping_app/app/data/repository/user_repository.dart';

class AuthService extends GetxService {
  late final _repo = FirebaseUserRepository();

  Future<void> registerWithEmail(
    String email,
    String password, {
    String? name,
  }) async {
    return _repo.signUpWithEmail(email, password, name: name);
  }

  get signInWithEmail => _repo.signInWithEmail;

  get signInWithGoogle => _repo.signInWithGoogle;

  get loginWithPhone => _repo.loginWithPhoneCreds;

  get initPhoneAuth => _repo.loginWithPhoneNumber;
}
