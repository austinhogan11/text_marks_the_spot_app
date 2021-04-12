import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_mock.dart';
import 'package:text_marks_the_spot_app/screens/home/show_textmark_message.dart';

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

  group('Testing ShowMessage widget build', () {
    GeoPoint testLocation = new GeoPoint(0, 0);
    String testTextMarkSenderUsername = 'fake_sender';
    String testTextMarkNickname = 'test_nick';
    String testTextMarkMessage = 'test_message';
    testWidgets('test successful build of ShowMessage widget',
        (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(42, 42);
      await tester.pumpWidget(createWidgetForTesting(
          child: new ShowMessage(testLocation, testTextMarkSenderUsername,
              testTextMarkNickname, testTextMarkMessage)));

      final widgetFinder = find.byType(ShowMessage);

      expect(widgetFinder, findsOneWidget);
    });
  });
}
