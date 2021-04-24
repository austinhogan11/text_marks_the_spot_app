import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';

final User currentUser = FirebaseAuth.instance.currentUser;

class ShowMessage extends StatefulWidget {
  static const String id = 'show_message';

  final GeoPoint currentLocation;
  final String textMarkSenderUsername;
  final String textMarkNickname;
  final String textMarkMessage;

  const ShowMessage(this.currentLocation, this.textMarkNickname,
      this.textMarkMessage, this.textMarkSenderUsername);

  @override
  _ShowMessageState createState() => _ShowMessageState();
}

var currentDate;
String textmarkDate;

class _ShowMessageState extends State<ShowMessage> {
  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    textmarkDate = currentDate.toString().substring(5, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 5500,
        color: Color(0xFF757575),
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 10.0),
            // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 0, 20.0),
                  child: Text(
                    widget.textMarkNickname,
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.textMarkMessage,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          widget.textMarkSenderUsername,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
