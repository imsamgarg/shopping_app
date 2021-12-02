import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/app/core/interfaces.dart';
import 'package:shopping_app/app/core/utils/helper.dart';

class FirebaseUserRepository extends UserInterface {
  late final _auth = FirebaseAuth.instance;
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

  get loginWithPhoneNumber => _auth.verifyPhoneNumber;

  Future<bool> loginWithPhoneCreds(AuthCredential credential) async {
    return await handleFirebaseAuthError(() async {
      final userCreds = await _auth.signInWithCredential(credential);
      return userCreds.additionalUserInfo!.isNewUser ? true : false;
    });
  }

  @override
  Future signInWithEmail(String email, String password) async {
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
  Future signUpWithEmail(String email, String password, {String? name}) async {
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
}
