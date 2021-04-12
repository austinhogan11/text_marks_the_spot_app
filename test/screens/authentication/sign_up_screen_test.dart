import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_mock.dart';
import 'package:text_marks_the_spot_app/screens/authentication/sign_up_screen.dart';

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

  group('Tests for the SignUpScreen Widget', () {
    //mocked classes
    testWidgets('testing successful build of SignUpScreen with no interactions',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: SignUpScreen()));

      final titleFinder = find.text('Account Creation');
      expect(titleFinder, findsOneWidget);
    });
    testWidgets(
        'testing input of username on SignUpScreen after successful build',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetForTesting(child: SignUpScreen()));

      final textFieldFinder = find.byType(TextField);
      await tester.enterText(textFieldFinder, 'testing_username_entry');
      await tester.pump();
      expect(find.text('testing_username_entry'), findsOneWidget);
    });
  });
}
