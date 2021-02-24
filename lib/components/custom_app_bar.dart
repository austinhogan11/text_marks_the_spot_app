import 'package:flutter/material.dart';

import '../constants.dart';

/*
      App bar design for Non-Homescreen Screens
      Features a back button for navigation
 */
class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      title: Text('Account Settings'),
    );
  }
}
