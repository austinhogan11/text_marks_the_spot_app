import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
