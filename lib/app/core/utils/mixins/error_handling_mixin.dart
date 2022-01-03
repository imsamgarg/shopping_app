import 'package:flutter/foundation.dart';

import 'package:custom_utils/log_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shopping_app/app/core/values/strings.dart';

import '../../interfaces.dart';
import '../helper.dart';

mixin ErrorHandlingMixin {
  String handleFirebaseAuthErrorCodes(String errorCode) {
    String _msg;
    switch (errorCode) {
      case "email-already-in-use":
        _msg = "Email Is Already In Use!! ";
        break;
      case "account-exists-with-different-credential":
        _msg = "User Already Exist On Email/Password Login ";
        break;
      case "user-disabled":
        _msg = "Your Account Has Been Disabled";
        break;
      case "invalid-email":
        _msg = "Email Address Is Invalid";
        break;
      case "weak-password":
        _msg = "Password Is Weak";
        break;
      case "wrong-password":
        _msg = "Wrong Email Or Password";
        break;
      case "user-not-found":
        _msg = "No User Found For This Email";
        break;
      case "invalid-verification-code":
        _msg = "Invalid Otp";
        break;
      case "invalid-verification-id":
        _msg = "Invalid Otp";
        break;
      default:
        _msg = errorMsg;
        break;
    }
    return _msg;
  }

  Future<T> handleFirebaseAuthError<T>(Future<T> Function() callback) async {
    try {
      return await callback();
    } on FirebaseAuthException catch (e, s) {
      customLog(
        "FirebaseAuthException  Error",
        name: "Error",
        error: e,
        stackTrace: s,
      );
      String _msg = handleFirebaseAuthErrorCodes(e.code);
      throw AuthException(_msg);
    } on Exception catch (e, s) {
      customLog(
        "FirebaseAuthException  Error",
        name: "Error",
        error: e,
        stackTrace: s,
      );
      throw const AuthException(errorMsg);
    }
  }

  Future handleAuthError(
    Future Function() callback, {
    VoidCallback? onFinally,
    VoidCallback? onError,
  }) async {
    try {
      await callback();
    } on AuthException catch (e) {
      onError?.call();
      errorSnackbar(e.errorMsg);
    } finally {
      onFinally?.call();
    }
  }

  Future digestError(
    dynamic Function() callback, {
    VoidCallback? onFinally,
  }) async {
    try {
      await callback();
    } catch (_) {
    } finally {
      onFinally?.call();
    }
  }
}
