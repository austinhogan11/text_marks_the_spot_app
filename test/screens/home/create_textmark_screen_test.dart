import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:text_marks_the_spot_app/screens/home/create_textmark_screen.dart';
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

  Widget createScaffoldForTesting({Widget child}) {
    return Scaffold(
      body: child,
    );
  }

  group('build tests for CreateTextMark Widget', () {
    testWidgets(
        'testing successful build of CreateTextMark Widget with no other factors',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(42, 42);

      var testingWidget = createWidgetForTesting(
          child: createScaffoldForTesting(child: new CreateTextMark()));

      await tester.pumpWidget(testingWidget);
      final widgetFinder = find.byType(CreateTextMark);

      expect(widgetFinder, findsOneWidget);
    });
  });
  group('Functionality tests for CreateTextMarkWidget', () {});
}
