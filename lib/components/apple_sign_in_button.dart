import 'package:apple_sign_in/scope.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/functionality/apple_sign_in.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

class AppleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      splashColor: Colors.black,
      onPressed: () {
        _signInWithApple(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      // highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/apple_icon.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Sign in with Apple",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService
          .signInWithApple(scopes: [Scope.email, Scope.fullName]);
      print('uid: ${user.uid}');
      Navigator.pushNamed(context, TemporaryHomeScreen.id);
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }
}
