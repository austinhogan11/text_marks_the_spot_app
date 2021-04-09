import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_marks_the_spot_app/screens/authentication/login_screen.dart';

Widget testingLoginScreenWidget({Widget child}) {
  return MaterialApp(
    home: child,
  );
}

void main() {
  testWidgets('Test build of login screen widget with no external calls',
      (WidgetTester tester) async {
    await tester.pumpWidget(testingLoginScreenWidget(child: new LoginScreen()));
    var loginScreenWidget = find.byType(LoginScreen);
    expect(loginScreenWidget, findsOneWidget);
  });
}
