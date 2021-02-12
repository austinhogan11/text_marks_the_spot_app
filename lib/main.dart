import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/functionality/apple_sign_in.dart';
import 'package:text_marks_the_spot_app/functionality/landing_page.dart';
import 'package:text_marks_the_spot_app/screens/login_screen.dart';
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
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Text Marks the Spot',
        // initialRoute: LandingPage.id,
        initialRoute: LoginScreen.id,
        routes: {
          LandingPage.id: (context) => LandingPage(),
          LoginScreen.id: (context) => LoginScreen(),
          TemporaryHomeScreen.id: (context) => TemporaryHomeScreen(),
        },
      ),
    );
  }
}
