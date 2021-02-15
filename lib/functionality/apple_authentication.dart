import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/screens/sign_up_screen.dart';
import 'package:text_marks_the_spot_app/screens/temporary_home_screen.dart';

class AppleAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(displayName: displayName);
        }
        bool isNewUser = authResult.additionalUserInfo.isNewUser;
        print('Sign in with Apple uid: ${firebaseUser.uid}');
        return isNewUser;

      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }
}

Future<void> signInWithAppleHandling(BuildContext context) async {
  try {
    final authService =
        Provider.of<AppleAuthentication>(context, listen: false);
    final isNewUser = await authService
        .signInWithApple(scopes: [Scope.email, Scope.fullName]);
    if (isNewUser)
      Navigator.pushNamed(context, SignUpScreen.id);
    else
      Navigator.pushNamed(context, TemporaryHomeScreen.id);
  } catch (e) {
    // TODO: Show alert here
    print(e);
  }
}
