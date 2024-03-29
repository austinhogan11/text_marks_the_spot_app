import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/user_authentication_handling.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'sign_up_screen';
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User loggedInUser = _auth.currentUser;
    String enteredUsername;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () => cancelAccountCreation(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Text('Account Creation'),
      ),
      backgroundColor: kAccentColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 65.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              CustomButton(
                color: Colors.white,
                btnText: 'Create',
                textColor: kPrimaryColor,
                onTap: () {
                  bool validUsername = DataHandling().saveNewUser(
                      loggedInUser.email, loggedInUser.uid, enteredUsername);
                  if (validUsername) {
                    Navigator.pushNamed(context, HomeScreen.id);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
