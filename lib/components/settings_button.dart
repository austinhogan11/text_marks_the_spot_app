import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/user_authentication_handling.dart';
import 'package:text_marks_the_spot_app/screens/login_screen.dart';

class SettingsButton extends StatelessWidget {
  final String btnText;
  final String screenNavRoute;

  SettingsButton({this.btnText, this.screenNavRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
      child: OutlineButton(
        splashColor: Colors.white,
        onPressed: () {
          if (screenNavRoute == LoginScreen.id) userSignOutHandling(context);
          Navigator.pushNamed(context, screenNavRoute);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.white, width: 2.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  btnText,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
