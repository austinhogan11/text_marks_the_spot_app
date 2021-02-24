import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/customButton.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User loggedInUser = _auth.currentUser;
    // print(loggedInUser.email);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, AccountScreen.id),
            icon: Icon(
              Icons.settings,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Text('Home'),
      ),
      backgroundColor: kAccentColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/map_ph.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.location_searching_sharp,
                    size: 55.0,
                    color: kPrimaryColor,
                  ),
                  onPressed: null),
              SizedBox(
                height: 650.0,
              ),
              CustomButton(
                color: kPrimaryColor,
                textColor: Colors.white,
                btnText: 'Create a Text Mark',
                onTap: () => print('Create a Text Mark pressed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
