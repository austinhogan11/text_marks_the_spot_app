import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_authentication.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/change_username_screen.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/changed_username_screen.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/help_screen.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/location_services_screen.dart';
import 'package:text_marks_the_spot_app/screens/authentication/login_screen.dart';
import 'package:text_marks_the_spot_app/screens/authentication/sign_up_screen.dart';
import 'package:text_marks_the_spot_app/screens/home_screen.dart';
import 'package:text_marks_the_spot_app/screens/messages/textmarks_page_view.dart';
import 'package:text_marks_the_spot_app/screens/messages/received_textmarks_screen.dart';

import 'functionality/authentication/apple_sign_in_available.dart';

void main() async {
  // Area used to run the app, most of the code is related to apple authentication.
  // Fix for: Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(
    Provider<AppleSignInAvailable>.value(
      value: appleSignInAvailable,
      child: TextMarksTheSpot(),
    ),
  );
}

class TextMarksTheSpot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppleAuthentication>(
      create: (context) => AppleAuthentication(),
      child: MaterialApp(
        title: 'Text Marks the Spot',

        // Application Screen Navigation set up
        initialRoute: LoginScreen.id,
        // initialRoute: TextmarksPageView.id,
        // initialRoute: HomeScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          AccountScreen.id: (context) => AccountScreen(),
          TextmarksPageView.id: (context) => TextmarksPageView(),
          ChangeUserNameScreen.id: (context) => ChangeUserNameScreen(),
          ChangedUsernameScreen.id: (context) => ChangedUsernameScreen(),
          LocationServicesScreen.id: (context) => LocationServicesScreen(),
          HelpScreen.id: (context) => HelpScreen(),
        },
      ),
    );
  }
}
