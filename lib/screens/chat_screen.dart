import 'package:firebase_auth/firebase_auth.dart';
import 'package:startupx/screens/baithahua.dart';
import 'login_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/constants.dart';
import '../widgets/messagebuilder.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:startupx/globals.dart';
import 'welcomepage.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  late var doc_id;
  ChatScreen(this.doc_id);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fieldText = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;
  late String text;
  late var loggedinuser;
  late String email;
  var flist = [];

  late var doc_id;
  void refresh() {
    setState(() {
      saving = false;
    });
  }

  void getuserid() {
    if (_auth.currentUser != null) {
      loggedinuser = _auth.currentUser;
      email = loggedinuser.phoneNumber;
      doc_id = widget.doc_id;
      print(email);
    }
  }

  @override
  void initState() {
    super.initState();
    getuserid();
    _store
        .collection("orders")
        .doc(doc_id)
        .collection('messages')
        .snapshots()
        .listen(
      (event) {
        if (event.docs.isNotEmpty) {
          setState(() {
            saving = false;
          });
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: saving,
      progressIndicator: CircularProgressIndicator(
        semanticsLabel: 'finding..',
      ),
      child: Scaffold(
        appBar: AppBar(
            leading: null,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    _store.collection('orders').doc(doc_id).delete();
                    Navigator.popAndPushNamed(context, baitha.pageid);
                  })
            ],
            title: Text('⚡️Chat'),
            backgroundColor: Colors.black),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              messagesbuilder(
                store: _store,
                email: email,
                doc_id: doc_id,
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          text = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                        controller: fieldText,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _store
                            .collection('orders')
                            .doc(doc_id)
                            .collection('messages')
                            .add(
                          {
                            'created on': DateTime.now().millisecondsSinceEpoch,
                            'message': text,
                            'sender': email
                          },
                        );
                        fieldText.clear();
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
