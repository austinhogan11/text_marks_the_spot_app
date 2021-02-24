import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/data/user_data_handling.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/changed_username_screen.dart';

import '../../constants.dart';

class ChangeUserNameScreen extends StatelessWidget {
  static const String id = 'change_username_screen';
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User loggedInUser = _auth.currentUser;
    String newUsername;
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Text('Change Username'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 65.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter a new username:',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) => newUsername = value,
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  bool validUsername = UserDataHandling()
                      .updateUsername(loggedInUser.uid, newUsername);
                  if (validUsername) {
                    Navigator.pushNamed(context, ChangedUsernameScreen.id);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
