import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_sign_in_available.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/user_authentication_handling.dart';
import 'package:text_marks_the_spot_app/screens/authentication/login_screen.dart';
import '../../firebase_mock.dart';
import 'login_screen_test.mocks.dart';

@GenerateMocks([AppleSignInAvailable])
void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });
  Widget createWidgetForTesting({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  group(
      'Widget Creation Tests for login_screen.dart covering status of apple authentication',
      () {
    final appleSignInAvailableMock = MockAppleSignInAvailable();
    testWidgets(
        'Testing for successful creation of LoginScreen when apple sign in is available',
        (WidgetTester tester) async {
      when(appleSignInAvailableMock.isAvailable).thenAnswer((_) => true);

      await tester.pumpWidget(Provider<AppleSignInAvailable>.value(
        value: appleSignInAvailableMock,
        child: createWidgetForTesting(child: LoginScreen()),
      ));
      final typeFinder = find.byType(LoginScreen);

      expect(typeFinder, findsOneWidget);
    });
    testWidgets(
        'Testing for successful creation of LoginScreen when apple sign in is not available',
        (WidgetTester tester) async {
      when(appleSignInAvailableMock.isAvailable).thenAnswer((_) => false);

      await tester.pumpWidget(Provider<AppleSignInAvailable>.value(
        value: appleSignInAvailableMock,
        child: createWidgetForTesting(child: LoginScreen()),
      ));

      final typeFinder = find.byType(LoginScreen);

      expect(typeFinder, findsOneWidget);
    });
    testWidgets(
        'Testing that when apple sign in is not available, the only button displayed is to login with google',
        (WidgetTester tester) async {
      when(appleSignInAvailableMock.isAvailable).thenAnswer((_) => false);

      await tester.pumpWidget(Provider<AppleSignInAvailable>.value(
        value: appleSignInAvailableMock,
        child: createWidgetForTesting(child: LoginScreen()),
      ));
      final buttonFinder = find.byType(CustomButton);
      expect(buttonFinder, findsOneWidget);
    });
    testWidgets(
        'Testing that when apple sign in is available, two custom buttons are displayed on the widget',
        (WidgetTester tester) async {
      when(appleSignInAvailableMock.isAvailable).thenAnswer((_) => true);

      await tester.pumpWidget(Provider<AppleSignInAvailable>.value(
        value: appleSignInAvailableMock,
        child: createWidgetForTesting(child: LoginScreen()),
      ));
      final buttonFinder = find.byType(CustomButton);
      expect(buttonFinder, findsWidgets);
    });
  });
}
