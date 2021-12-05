import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/app/core/interfaces.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/utils/typedefs.dart';

class FirebaseUserRepository extends UserInterface {
  final _auth = FirebaseAuth.instance;
  late final _user = _auth.currentUser;

  @override
  String get phoneNumber => _user?.phoneNumber ?? "Not Provided";

  @override
  String? get profileUrl => _user?.photoURL;

  @override
  Future<String>? get token => _auth.currentUser?.getIdToken();

  @override
  String get uid => _user?.uid ?? "";

  @override
  String get userName => _user?.displayName ?? "";

  Future<void> loginWithPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 30),
    int? forceResendingToken,
  }) {
    return _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: timeout,
      forceResendingToken: forceResendingToken,
    );
  }

  Future<bool> loginWithPhoneCreds(AuthCredential credential) async {
    return await handleFirebaseAuthError(() async {
      final userCreds = await _auth.signInWithCredential(credential);
      return userCreds.additionalUserInfo!.isNewUser ? true : false;
    });
  }

  Future<void> linkWithCreds(AuthCredential credential) async {
    return await handleFirebaseAuthError(() async {
      await _user!.linkWithCredential(credential);
    });
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    return await handleFirebaseAuthError(() async {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    });
  }

  @override
  Future<bool> signInWithGoogle() async {
    return await handleFirebaseAuthError(() async {
      final user = await GoogleSignIn(
        clientId:
            "280884416298-nllg2aj0vht32fq6vboepi0h4f7lb7e2.apps.googleusercontent.com",
      ).signIn();
      final googleAuth = await user!.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCreds = await _auth.signInWithCredential(cred);
      return userCreds.additionalUserInfo!.isNewUser ? true : false;
    });
  }

  @override
  Future<void> signUpWithEmail(String email, String password,
      {String? name}) async {
    return await handleFirebaseAuthError(() async {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await updateName(name ?? "user");
    });
  }

  @override
  Future updateName(String name) async {
    return await _auth.currentUser?.updateDisplayName(name);
  }

  @override
  Future<bool> isUserLogged() async {
    final user = await _auth.authStateChanges().first;
    return user != null;
  }

  @override
  Future sendPassResetEmail(String email) async {
    return await handleFirebaseAuthError(() async {
      await _auth.sendPasswordResetEmail(email: email);
    });
  }
}
