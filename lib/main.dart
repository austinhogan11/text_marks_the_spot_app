import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/screens/login_screen.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

void main() {
  runApp(TextMarksTheSpot());
}

class TextMarksTheSpot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        TemporaryHomeScreen.id: (context) => TemporaryHomeScreen(),
      },
    );
  }
}
