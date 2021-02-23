import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/avatar.dart';
import 'package:text_marks_the_spot_app/components/settings_button.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/change_username_screen.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/help_screen.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/location_services_screen.dart';
import 'package:text_marks_the_spot_app/screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  static const String id = 'account_screen';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: AppBar(
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
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  child: Avatar(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '<username>',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SettingsButton(
                btnText: 'Change Username',
                screenNavRoute: ChangeUserNameScreen.id,
              ),
              SettingsButton(
                btnText: 'Location Services',
                screenNavRoute: LocationServicesScreen.id,
              ),
              SettingsButton(
                btnText: 'Help',
                screenNavRoute: HelpScreen.id,
              ),
              SettingsButton(
                btnText: 'Logout',
                screenNavRoute: LoginScreen.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
