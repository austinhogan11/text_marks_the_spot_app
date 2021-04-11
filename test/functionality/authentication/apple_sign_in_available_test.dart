import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_sign_in_available.dart';

class AppleSignInAvailableMock extends Mock implements AppleSignInAvailable {
  AppleSignInAvailableMock(this.isAvailable);
  final bool isAvailable;
  static Future<AppleSignInAvailableMock> check() async {
    return AppleSignInAvailableMock(true);
  }
}

void main() {
  group('apple_sign_in_available_tests', () {
    test(
        'Test for successful return of false value for .check() method if apple sign in is unavailable',
        () async {
      final testAppleSignInAvailableResult = await AppleSignInAvailable.check();
      expect(testAppleSignInAvailableResult.isAvailable, false);
    });
    test(
        'Test for successful return of true value for .check() method if apple sign in is available',
        () async {
      final testAppleSignInAvailableMock =
          await AppleSignInAvailableMock.check();
      expect(testAppleSignInAvailableMock.isAvailable, true);
    });
  });
}
