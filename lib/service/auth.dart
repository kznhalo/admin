import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../data/constant.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> onAuthChange() => _firebaseAuth.authStateChanges();
  Future<IdTokenResult> gettokenResult() =>
      _firebaseAuth.currentUser!.getIdTokenResult(true);

  /////////////
  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn({required String email, required String password}) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(
      {required String email, required String password}) async {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> verifyEmail(
    String email,
    void Function(ApplicationLoginState state) stateCallBack,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        stateCallBack(ApplicationLoginState.password);
      } else {
        stateCallBack(ApplicationLoginState.register);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("********************LoginRegisterError: $e************");
    }
  }

  /////////////////

  Future<void> login({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) =>
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
  //Login with phone number in Web
  Future<void> loginInWeb({
    required String phoneNumber,
    required void Function(void Function(String code)) enterCode,
  }) async {
    await _firebaseAuth
        .signInWithPhoneNumber(phoneNumber)
        .then((confirmationResult) {
      //Confirm with phone code
      enterCode((phoneCode) {
        //The time user have filled phone code and pressed confirm
        confirmationResult
            .confirm(phoneCode) //CONFIRM
            .then((value) => _firebaseAuth.signInWithCredential(
                value.credential!)); //SIGN IN WITH CREDENTIAL
      });
    });
  }

  Future<void> loginWithCerdential(AuthCredential credential) =>
      _firebaseAuth.signInWithCredential(credential);

  Future<void> logout() => _firebaseAuth.signOut();
}
