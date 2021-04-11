import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_marks_the_spot_app/screens/messages/textmarks_page_view.dart';
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

  testWidgets(
      'Testing for successful creation of main TextmarksPageView Widget',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(createWidgetForTesting(child: new TextmarksPageView()));

    final typeFinder = find.byType(TextmarksPageView);

    expect(typeFinder, findsOneWidget);
  });
}
