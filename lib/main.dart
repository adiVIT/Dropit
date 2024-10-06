import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/baithahua.dart';
import 'screens/chalega.dart';
import 'screens/login_screen.dart';
import 'screens/welcomepage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MyHomePage.pageid: (context) => MyHomePage(title: 'homie'),
        chalega.pageid: (context) => chalega(),
        baitha.pageid: (context) => baitha(),
      },
    );
  }
}
