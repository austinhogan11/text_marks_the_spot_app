import 'package:flutter/material.dart';

import '../constants.dart';

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(
        Icons.person,
        color: kPrimaryColor,
        size: 45.0,
      ),
      backgroundColor: Colors.white,
      radius: 35.0,
    );
  }
}
