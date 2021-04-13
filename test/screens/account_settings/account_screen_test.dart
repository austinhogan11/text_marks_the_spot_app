import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';
import '../../firebase_mock.dart';

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

  group('testing account screen widget', () {
    final mockUser = MockUser();
    testWidgets('testing successful build of AccountScreen widget',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(42, 42);

      await tester
          .pumpWidget(createWidgetForTesting(child: new AccountScreen()));

      final titleFinder = find.text('Account Settings');
      expect(titleFinder, findsOneWidget);
    });
  });
}
