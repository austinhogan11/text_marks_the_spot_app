import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/components/sign_in_button.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_sign_in_available.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/user_authentication_handling.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
      body: Container(
        color: kPrimaryColor,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300.0,
                  height: 300.0,
                  child: Image.asset('assets/tmts_logo.png'),
                ),
                SignInButton(
                  image: 'google_logo.png',
                  buttonText: 'Continue with Google',
                  signInFunction: () => signInWithGoogleHandling(context),
                ),
                SizedBox(height: 15.0),
                if (appleSignInAvailable.isAvailable)
                  SignInButton(
                    image: 'apple_icon.png',
                    buttonText: 'Continue with Apple',
                    signInFunction: () => signInWithAppleHandling(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
