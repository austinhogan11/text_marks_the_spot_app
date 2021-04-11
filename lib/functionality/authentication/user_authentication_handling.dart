import 'package:apple_sign_in/scope.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_authentication.dart';
import 'package:text_marks_the_spot_app/screens/authentication/login_screen.dart';
import 'package:text_marks_the_spot_app/screens/authentication/sign_up_screen.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';

import 'google_authentication.dart';

Future<void> signInWithGoogleHandling(BuildContext context) async {
  // New users are routed to the sign up screen, Existing users to the home screen
  try {
    signInWithGoogle().then((isNewUser) {
      authenticationScreenRouting(context, isNewUser);
    });
  } catch (e) {
    print(e);
  }
}

Future<void> signInWithAppleHandling(BuildContext context) async {
  try {
    final authService =
        Provider.of<AppleAuthentication>(context, listen: false);
    final isNewUser = await authService
        .signInWithApple(scopes: [Scope.email, Scope.fullName]);
    authenticationScreenRouting(context, isNewUser);
  } catch (e) {
    print(e);
  }
}

void authenticationScreenRouting(BuildContext context, bool isNewUser) {
  if (isNewUser)
    Navigator.pushNamed(context, SignUpScreen.id);
  else
    Navigator.pushNamed(context, HomeScreen.id);
}

void userSignOutHandling(BuildContext context) {
  try {
    signOutGoogle();
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, LoginScreen.id);
  } catch (e) {
    print(e);
  }
}

Future<void> cancelAccountCreation(BuildContext context) async {
  try {
    await FirebaseAuth.instance.currentUser.delete();
    Navigator.pop(context);
    print('Account creation cancelled and removed from firebase auth');
  } catch (e) {
    print(e);
    print('Failed to cancel account creation.');
  }
}
