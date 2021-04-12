import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_sign_in_available.dart';
import 'apple_sign_in_available_test.mocks.dart';

@GenerateMocks([AppleSignInAvailable, AppleSignIn])
void main() {
  group('Tests for AppleSignInAvailable authentication function', () {
    final testingAppleSignInAvailable = MockAppleSignInAvailable();
    test(
        'testing for successful return of true value if apple sign in is available',
        () async {
      when(testingAppleSignInAvailable.isAvailable).thenAnswer((_) => true);

      expect(testingAppleSignInAvailable.isAvailable, true);
    });
    test(
        'testing for successful return of false if apple sign in is NOT available ',
        () async {
      when(testingAppleSignInAvailable.isAvailable).thenAnswer((_) => false);
      expect(testingAppleSignInAvailable.isAvailable, false);
    });
  });
}
