import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/google_authentication.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

class UserMock extends Mock implements User {}

class GoogleSignInMock extends Mock implements GoogleSignIn {}

class GoogleSignInAuthenticationMock extends Mock
    implements GoogleSignInAuthentication {}

class GoogleSignInAccountMock extends Mock implements GoogleSignInAccount {}

class GoogleAuthProviderMock extends Mock implements GoogleAuthProvider {}

class AuthCredentialMock extends Mock implements AuthCredential {}

class CredentialMock extends Mock implements OAuthCredential {}

class UserCredentialMock extends Mock implements UserCredential {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Google Auth Tests', () {
    final FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
    final GoogleSignInMock googleSignInMock = GoogleSignInMock();
    final UserMock userMock = UserMock();
    final GoogleSignInAccountMock googleSignInAccountMock =
        GoogleSignInAccountMock();
    final GoogleSignInAuthenticationMock googleSignInAuthenticationMock =
        GoogleSignInAuthenticationMock();
    final GoogleAuthProviderMock googleAuthProviderMock =
        GoogleAuthProviderMock();

    final CredentialMock credentialMock = CredentialMock();

    final UserCredentialMock userCredentialMock = UserCredentialMock();

    test('Sign In with Google Returns a User', () async {
      when(googleSignInMock.signIn()).thenAnswer((_) =>
          Future<GoogleSignInAccountMock>.value(googleSignInAccountMock));

      when(googleSignInAccountMock.authentication).thenAnswer((_) =>
          Future<GoogleSignInAuthenticationMock>.value(
              googleSignInAuthenticationMock));

      when(firebaseAuthMock.signInWithCredential(credentialMock)).thenAnswer(
          (_) => Future<UserCredentialMock>.value(userCredentialMock));

      when(userCredentialMock.user).thenAnswer((_) => userMock);

      expect(await signInWithGoogle(), true);
    });
  });
}
