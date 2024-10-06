import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';

class baitha extends StatefulWidget {
  static String pageid = 'baithahua';
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  baitha({super.key});

  @override
  State<baitha> createState() => _baithaState();
}

class _baithaState extends State<baitha> {
  final fieldText = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  late String text;
  late var loggedinuser;
  late String email;

  static List<String> locations = [
    'main to sjt',
    'main to lblock',
    'main to sjt',
    'main to rblock',
    'main to nblock',
    'main to mblock',
    'main to jblock',
  ];
  Iterable<String> display = List.from(locations);
  void some_function(int index) {}

  void updatedisplay(String value) {
    setState(() {
      display =
          locations.where((element) => element.toLowerCase().contains(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
              decoration: textfield_email_inputdecoration_lr.copyWith(
                  hintText: 'enter your location'),
              onChanged: ((value) {
                updatedisplay(value);
              })),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: display.length,
                itemBuilder: ((context, index) => TextButton(
                      style:
                          ButtonStyle(elevation: MaterialStateProperty.all(1)),
                      onPressed: (() async {
                        _store.collection('orders').add({
                          'location': display.elementAt(index),
                          'receiverphone': _auth.currentUser?.phoneNumber,
                          'status': 'disabled',
                        }).then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(value.id),
                            )));
                      }),
                      child: Text(
                        display.elementAt(index),
                      ),
                    ))),
          ),
        ],
      ))),
    );
  }
}
