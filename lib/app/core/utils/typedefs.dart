import 'package:firebase_auth/firebase_auth.dart';

typedef PhoneAuthCallback = Future<void> Function(
    {String? autoRetrievedSmsCodeForTesting,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
    required PhoneCodeSent codeSent,
    int? forceResendingToken,
    required String phoneNumber,
    Duration timeout,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed});
