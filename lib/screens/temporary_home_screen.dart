import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/user_authentication_handling.dart';

class TemporaryHomeScreen extends StatelessWidget {
  static const String id = 'temp_home_screen';
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User loggedInUser = _auth.currentUser;
    print(loggedInUser.email);
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
              color: Color(0xFF393E46),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => userSignOutHandling(context),
            ),
          ],
        ),
      ),
    );
  }
}
