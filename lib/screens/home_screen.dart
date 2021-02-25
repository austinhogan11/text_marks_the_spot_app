import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        icon: kSettingsIconButton,
        iconFunction: () => Navigator.pushNamed(context, AccountScreen.id),
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
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.location_searching_sharp,
                          size: 55.0,
                          color: kPrimaryColor,
                        ),
                        onPressed: null),
                  ],
                ),
                Expanded(
                  child: SizedBox(),
                ),
                CustomButton(
                  color: kPrimaryColor,
                  textColor: Colors.white,
                  btnText: 'Create a Text Mark',
                  fontSize: 22.5,
                  onTap: () => print('Create a Text Mark pressed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
