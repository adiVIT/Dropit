import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startupx/screens/chat_screen.dart';
import '../constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class chalega extends StatefulWidget {
  static String pageid = 'chalegahua';
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  chalega({super.key});

  @override
  State<chalega> createState() => _chalegaState();
}

class _chalegaState extends State<chalega> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
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
          StreamBuilder<QuerySnapshot>(
            stream: _store.collection('orders').snapshots(),
            builder: (context, snapshot) {
              List<Widget> text = [];
              if (snapshot.hasData) {
                var orders = snapshot.data!.docs;
                for (var order in orders) {
                  if (order['status'] != 'enabled') {
                    Widget f = TextButton(
                      style:
                          ButtonStyle(elevation: MaterialStateProperty.all(1)),
                      onPressed: (() async {
                        var id = order.reference.id;
                        String? phonenumber = _auth.currentUser?.phoneNumber;
                        await _store.collection('orders').doc(id).update({
                          'status': 'enabled',
                          'deliveryphone': phonenumber
                        });

                        await _store
                            .collection('orders')
                            .doc(id)
                            .collection('messages')
                            .add({
                          "message": "ok",
                          "sender": "ok",
                          'created on': DateTime.now().millisecondsSinceEpoch,
                        });

                        _store.collection("cities").doc("LA").set({
                          'status': 'enabled',
                          'location': 'none',
                        });
                        await _store.collection('orders').doc("LA").delete();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(id),
                            ));
                      }),
                      child: Text(
                        order['location'],
                      ),
                    );
                    text.add(f);
                  }
                }
              }
              return Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: text,
                ),
              );
            },
          )
        ],
      ))),
    );
  }
}
