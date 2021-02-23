import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';

class TemporaryHomeScreen extends StatelessWidget {
  static const String id = 'temp_home_screen';
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User loggedInUser = _auth.currentUser;
    print(loggedInUser.email);
    return Scaffold(
      backgroundColor: kAccentColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Text Marks the Spot',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton(
              color: kPrimaryColor,
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, AccountScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
