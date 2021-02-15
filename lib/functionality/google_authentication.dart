import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:text_marks_the_spot_app/screens/sign_up_screen.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<bool> signInWithGoogle() async {
  await Firebase.initializeApp();

  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await googleSignIn.signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    final userAdditionalInfo = authResult.additionalUserInfo;
    bool isNewUser = authResult.additionalUserInfo.isNewUser;
    print('signInWithGoogle succeeded: \n'
        '\nGoogle User Information: $user  \n'
        '\nAdditional User Information: $userAdditionalInfo');
    return isNewUser;
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

Future<void> signInWithGoogleHandling(BuildContext context) async {
  // New users are routed to the sign up screen, Existing users to the home screen
  try {
    signInWithGoogle().then((isNewUser) {
      if (isNewUser) {
        Navigator.pushNamed(context, SignUpScreen.id);
      } else {
        Navigator.pushNamed(context, TemporaryHomeScreen.id);
      }
    });
  } catch (e) {
    print(e);
  }
}
