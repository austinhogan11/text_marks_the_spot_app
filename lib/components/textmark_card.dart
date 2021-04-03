import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';

class TextmarkCard extends StatelessWidget {
  final String date;
  final String username;
  final bool isSender;
  final String locationNickname;
  final GeoPoint coordinates;

  TextmarkCard(
      {this.date,
      this.username,
      this.isSender,
      this.locationNickname,
      this.coordinates});

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
        onTap: () {
          Navigator.pushNamed(context, HomeScreen.id);
          // TODO: Pass coordinates to Map display & display Textmark pin
          print(['${coordinates.latitude},${coordinates.longitude}']);
        },
      ),
    );
  }
}
