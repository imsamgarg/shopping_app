import 'package:custom_utils/log_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/app/core/interfaces.dart';
import 'package:shopping_app/app/core/utils/mixins/error_handling_mixin.dart';

class FirebaseUserRepository extends UserInterface with ErrorHandlingMixin {
  static final FirebaseUserRepository instance = FirebaseUserRepository._();

  factory FirebaseUserRepository() {
    return instance;
  }

  FirebaseUserRepository._() {
    _auth.authStateChanges().listen((event) {
      _user = event;
    });
  }
  final _auth = FirebaseAuth.instance;
  User? _user;

  @override
  String get phoneNumber {
    customLog(_user!.phoneNumber);
    if (_user?.phoneNumber != null && _user!.phoneNumber!.isNotEmpty) {
      return _user!.phoneNumber!;
    }
    return "Tap To Add";
  }

  @override
  String? get profileUrl => _user?.photoURL;

  @override
  Future<String>? get token => _auth.currentUser?.getIdToken();

  @override
  String get uid => _user?.uid ?? "";

  @override
  String get userName => _user?.displayName ?? "Fashion 24x7 User";

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
      _user = (await _user!.linkWithCredential(credential)).user;
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

  Future<void> linkWithGoogle() async {
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

      _user = (await _user!.linkWithCredential(cred)).user;

      return;
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

  bool get hasGoogleProvider {
    return _user!.providerData
        .where((element) {
          return element.providerId.contains("google");
        })
        .toList()
        .isNotEmpty;
  }

  bool get hasMailProvider {
    customLog(_user!.providerData);

    return _user!.providerData
        .where((element) {
          return element.providerId.contains("password");
        })
        .toList()
        .isNotEmpty;
  }

  String get googleEmail {
    final list = _user!.providerData.where((element) {
      return element.providerId.contains("google");
    }).toList();
    if (list.isEmpty) return "Tap To Connect";
    return list.first.email!;
  }

  String get mailAddress {
    final list = _user!.providerData.where((element) {
      return element.providerId.contains("password");
    }).toList();
    if (list.isEmpty) return "Tap To Connect";
    return list.first.email!;
  }

  bool get hasPhoneProvider {
    return _user!.phoneNumber != null && _user!.phoneNumber!.isNotEmpty;
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
