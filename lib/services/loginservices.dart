import 'package:flutter/material.dart';
import 'package:startupx/services/otpscreen.dart';
import '../widgets/lrbutton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupx/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:startupx/screens/welcomepage.dart';

class loginservices {
  FirebaseAuth _auth;
  BuildContext context;
  String phonrnnumber;
  loginservices(this._auth, this.context, this.phonrnnumber);
  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    await _auth.signInWithCredential(phoneAuthCredential);
    if (_auth.currentUser != null) {
      Navigator.pushNamed(context, MyHomePage.pageid);
    }
  }

  void verificationFailed(FirebaseAuthException e) async {
    print(e.message);
  }

  void codeSent(String verificationId, int? smscode) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OTPPage(verificationId, _auth)));
  }

  void codeAutoRetrievalTimeout(String error) async {}

  Future<void> login_with_phonenumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: '+91 ${phonrnnumber}',
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
