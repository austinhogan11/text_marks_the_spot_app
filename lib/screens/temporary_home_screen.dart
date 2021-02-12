import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';

class TemporaryHomeScreen extends StatelessWidget {
  static const String id = 'temp_home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          'Text Marks the Spot',
          style: TextStyle(
            fontSize: 35.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
