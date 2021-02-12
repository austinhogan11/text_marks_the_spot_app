import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/screens/login_screen.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

/* NOT CURRENTLY BEING UTILIZED  - May be removed */

class LandingPage extends StatelessWidget {
  static const String id = 'landing_page';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      // stream: FirebaseAuth.instance.onAuthStateChanged,
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          }
          // Navigator.pushNamed(context, TemporaryHomeScreen.id);
          return TemporaryHomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
