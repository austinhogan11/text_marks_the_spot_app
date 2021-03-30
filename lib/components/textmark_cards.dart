import 'package:flutter/material.dart';

class ReceivedTextmarkCard extends StatelessWidget {
  final String date;
  final String sender;
  final String locationNickname;

  ReceivedTextmarkCard({this.date, this.sender, this.locationNickname});

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
        title: Text("Textmark from $sender"),
        subtitle: Text(locationNickname),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}

class SentTextmarkCard extends StatelessWidget {
  final String date;
  final String recipient;
  final String locationNickname;

  SentTextmarkCard({this.date, this.recipient, this.locationNickname});

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
        title: Text("Textmark sent to $recipient"),
        subtitle: Text(locationNickname),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
