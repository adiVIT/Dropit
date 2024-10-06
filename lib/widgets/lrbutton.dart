import 'package:flutter/material.dart';

class lrbutton extends StatelessWidget {
  late Color color;
  late VoidCallback action;
  late String txt;
  lrbutton(this.color, this.action, this.txt);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (() {
            action();
          }),
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            txt,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
