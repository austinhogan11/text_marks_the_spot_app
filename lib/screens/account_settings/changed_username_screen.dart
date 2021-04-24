import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';

import '../../constants.dart';

class ChangedUsernameScreen extends StatelessWidget {
  static const String id = 'changed_username_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, AccountScreen.id),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Text('Change Username'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 45.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username changed successfully!',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              CustomButton(
                color: Colors.white,
                textColor: kPrimaryColor,
                btnText: 'Back',
                onTap: () => Navigator.pushNamed(context, AccountScreen.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
