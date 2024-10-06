import 'package:flutter/material.dart';

class messagebubble extends StatelessWidget {
  const messagebubble({
    Key? key,
    required this.text,
    required this.sender,
    required this.isme,
    required this.time,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isme;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: sender == "ok"
              ? CrossAxisAlignment.center
              : (isme ? CrossAxisAlignment.start : CrossAxisAlignment.end),
          children: [
            Text(
              sender == "ok" ? "chat initiated" : sender,
              style: (sender == "ok"
                  ? TextStyle(color: Colors.white38, fontSize: 12)
                  : TextStyle(color: Colors.white38, fontSize: 12)),
            ),
            Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 10.0,
                color: isme ? Colors.indigo.shade900 : Colors.teal,
                child: sender == 'ok'
                    ? Text('')
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          '${text}',
                          style: TextStyle(fontSize: 15),
                        ),
                      )),
            Text(
              DateTime.fromMillisecondsSinceEpoch(time).hour.toString() +
                  ':' +
                  DateTime.fromMillisecondsSinceEpoch(time).minute.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ));
  }
}
