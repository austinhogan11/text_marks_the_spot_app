import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';
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

  group('Tests for HomeScreen widget', () {
    testWidgets('testing successful build of HomeScreen widget on app start',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(42, 42);

      await tester.pumpWidget(createWidgetForTesting(child: new HomeScreen()));

      final titleFinder = find.text('Home');
      expect(titleFinder, findsOneWidget);
    });
  });
}
