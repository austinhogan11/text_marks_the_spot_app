import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/help_screen.dart';

Widget testingHelpScreenWidget({Widget child}) {
  return MaterialApp(
    home: child,
  );
}

void main() {
  testWidgets('Test build of help screen widget with no external calls',
      (WidgetTester tester) async {
    await tester.pumpWidget(testingHelpScreenWidget(child: new HelpScreen()));
    var helpScreenWidget = find.byType(HelpScreen);
    expect(helpScreenWidget, findsOneWidget);
  });
}
