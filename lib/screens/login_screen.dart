import 'package:flutter/material.dart';
import 'package:startupx/services/loginservices.dart';
import '../widgets/lrbutton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'welcomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _saving = false;
  final _auth = FirebaseAuth.instance;
  late String email = '';
  String password = '';
  late var newuser;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      inAsyncCall: _saving,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 45),
                child: ImageIcon(
                  AssetImage('assets/images/icon.png'),
                  size: 200,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: textfield_email_inputdecoration_lr.copyWith(
                      hintText: 'Enter Your Phone')),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 24.0,
              ),
              lrbutton(login_button_color, (() async {
                loginservices login = loginservices(_auth, context, email);
                setState(() {
                  _saving = true;
                });
                await login.login_with_phonenumber();
                User? newuser = _auth.currentUser;
                final SharedPreferences cred =
                    await SharedPreferences.getInstance();
                cred.setString(
                  'uid',
                  newuser!.uid,
                );
              }), 'sendotp'),
            ],
          ),
        ),












        
      ),
    );
  }
}
