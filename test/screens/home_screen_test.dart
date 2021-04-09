import 'package:flutter_test/flutter_test.dart';
import 'package:text_marks_the_spot_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('home screen ...', (WidgetTester tester) async {
    await tester.pumpWidget(HomeScreen());
    var homeScreenWidget = find.byType(StatefulWidget);
    expect(homeScreenWidget, findsOneWidget);
  });
}
