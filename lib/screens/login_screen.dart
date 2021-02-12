import 'package:apple_sign_in/scope.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/sign_in_button.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/functionality/apple_sign_in.dart';
import 'package:text_marks_the_spot_app/functionality/apple_sign_in_available.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/functionality/google_sign_in.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

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
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 150),
                SizedBox(height: 150.0),
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

  Future<void> signInWithGoogleHandling(BuildContext context) async {
    try {
      signInWithGoogle().then((result) {
        if (result != null) {
          Navigator.pushNamed(context, TemporaryHomeScreen.id);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInWithAppleHandling(BuildContext context) async {
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
