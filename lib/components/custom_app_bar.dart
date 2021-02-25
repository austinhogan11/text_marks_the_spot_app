import 'package:flutter/material.dart';

import '../constants.dart';

/*
      App bar design for Non-Homescreen Screens
      Features a back button for navigation
 */
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Icon icon;
  final Function iconFunction;

  CustomAppBar({this.title, this.icon, this.iconFunction});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: IconButton(
          onPressed: iconFunction,
          icon: icon,
        ),
      ),
      backgroundColor: kPrimaryColor,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65.0);
}
