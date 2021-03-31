import 'package:flutter/material.dart';

class TextmarkCard extends StatelessWidget {
  final String date;
  final String username;
  final bool isSender;
  final String locationNickname;

  TextmarkCard(
      {this.date, this.username, this.isSender, this.locationNickname});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          date,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        title: (isSender)
            ? Text("Textmark sent to $username")
            : Text("Textmark from $username"),
        subtitle: Text(locationNickname),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
