abstract class DatabaseInterface {}

abstract class UserInterface {
  Future signUpWithEmail(String email, String password, {String name});
  Future signInWithEmail(String email, String password);
  Future sendPassResetEmail(String email);
  Future<bool> signInWithGoogle();
  Future updateName(String name);
  Future<bool> isUserLogged();
  String get userName;
  String get phoneNumber;
  String get uid;
  Future<String>? get token;
  String? get profileUrl;
}

class AuthException implements Exception {
  const AuthException(this.errorMsg);

  final String errorMsg;

  @override
  String toString() {
    return "Error Msg: $errorMsg";
  }
}
