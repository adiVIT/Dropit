import 'package:flutter/material.dart';
import 'package:startupx/screens/baithahua.dart';
import 'package:startupx/screens/chalega.dart';
import 'package:startupx/widgets/lrbutton.dart';

class MyHomePage extends StatefulWidget {
  static String pageid = 'welcomepage';
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void onclick() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              lrbutton(
                  Colors.blue,
                  (() => {Navigator.pushNamed(context, baitha.pageid)}),
                  'get delivered'),
              lrbutton(
                  Colors.blue,
                  (() => {Navigator.pushNamed(context, chalega.pageid)}),
                  'pick delivery'),
            ],
          ),
        )));
  }
}
