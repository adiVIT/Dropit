import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startupx/screens/welcomepage.dart';

class OTPPage extends StatefulWidget {
  OTPPage(this.verification, this._auth) {
    print(verification);
  }

  final String verification;
  final FirebaseAuth _auth;

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  @override
  void initState() {
    super.initState();
    verification = widget.verification;
  }

  final _formKey = GlobalKey<FormState>();
  static String pageid = 'otppage';

  late String otp = '';
  late String verification = '';

  void onsubmit(String message, String verificationId) async {
    PhoneAuthCredential phoneAuthCredential =
        await PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: message);
    await widget._auth.signInWithCredential(phoneAuthCredential);
    if (widget._auth.currentUser != null) {
      Navigator.pushNamed(context, MyHomePage.pageid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter OTP',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 10.0),
            Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'OTP',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  }
                  return null;
                },
                onChanged: (value) => otp = value,
              ),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                print(verification);
                print(otp);

                onsubmit(otp, verification);
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                print(widget.verification);
                onsubmit(otp, verification);
              },
              child: Text('Resend OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
