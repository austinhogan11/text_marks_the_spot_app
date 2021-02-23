import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/data/user_data_handling.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'sign_up_screen';
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User loggedInUser = _auth.currentUser;
    String enteredUsername;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 65.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200.0,
                height: 200.0,
                child: Image.asset('assets/tmts_logo.png'),
              ),
              Text(
                'Enter a Username:',
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
                onChanged: (value) => enteredUsername = value,
              ),
              SizedBox(
                height: 15.0,
              ),
              FlatButton(
                color: Color(0xFF393E46),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  bool validUsername = UserDataHandling().saveNewUser(
                      loggedInUser.email, loggedInUser.uid, enteredUsername);
                  if (validUsername) {
                    Navigator.pushNamed(context, TemporaryHomeScreen.id);
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
