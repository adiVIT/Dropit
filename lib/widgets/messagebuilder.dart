import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:startupx/globals.dart';

import 'messagebubble.dart';

class messagesbuilder extends StatefulWidget {
  const messagesbuilder({
    Key? key,
    required FirebaseFirestore store,
    required this.email,
    required this.doc_id,
  })  : _store = store,
        super(key: key);

  final FirebaseFirestore _store;
  final String email;
  final doc_id;

  @override
  State<messagesbuilder> createState() => _messagesbuilderState();
}

class _messagesbuilderState extends State<messagesbuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: widget._store
            .collection('orders')
            .doc(widget.doc_id)
            .collection("messages")
            .orderBy('created on')
            .snapshots(),
        builder: ((context, snapshot) {
          List<Widget> messagewidget = [];
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs;
            saving = false;

            for (var message in messages) {
              String text = message['message'];
              String sender = message['sender'];
              Widget f = messagebubble(
                  text: text,
                  sender: sender,
                  isme: sender == widget.email,
                  time: message['created on']);
              messagewidget.add(f);
            }
          }
          return Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messagewidget,
            ),
          );
        }));
  }
}
