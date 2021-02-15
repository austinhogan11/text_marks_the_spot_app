import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/functionality/apple_authentication.dart';

import 'package:text_marks_the_spot_app/screens/login_screen.dart';
import 'package:text_marks_the_spot_app/screens/sign_up_screen.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';
import 'functionality/apple_sign_in_available.dart';

void main() async {
  // Fix for: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: TextMarksTheSpot(),
  ));
}

class TextMarksTheSpot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppleAuthentication>(
      create: (context) => AppleAuthentication(),
      child: MaterialApp(
        title: 'Text Marks the Spot',
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          TemporaryHomeScreen.id: (context) => TemporaryHomeScreen(),
        },
      ),
    );
  }
}
