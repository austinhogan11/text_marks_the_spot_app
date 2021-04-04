import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  final Color color = Colors.white;
  final String title;
  final String content;
  final String confirm;
  final String cancel;
  final Function confirmOnPressed;
  final Function cancelOnPressed;

  CustomAlertDialog(
      {this.title,
      this.content,
      this.confirm,
      this.cancel,
      this.confirmOnPressed,
      this.cancelOnPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
      backgroundColor: color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(confirm),
          textColor: Colors.black,
          onPressed: () {
            this.confirmOnPressed();
          },
        ),
        new FlatButton(
          child: Text(cancel),
          textColor: Colors.black,
          onPressed: () {
            this.cancelOnPressed();
          },
        ),
      ],
    );
  }
}
