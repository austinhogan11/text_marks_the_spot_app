import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:text_marks_the_spot_app/screens/sign_up_screen.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

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
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    bool isNewUser = authResult.additionalUserInfo.isNewUser;
    print('signInWithGoogle succeeded: $user, newUser: $isNewUser');
    // return '$user';
    // return user;
    return isNewUser;
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

Future<void> signInWithGoogleHandling(BuildContext context) async {
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
