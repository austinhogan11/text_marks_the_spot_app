import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:text_marks_the_spot_app/screens/messages/textmarks_page_view.dart';

void main() {
  testWidgets('Test successful build of textmarks_page_view widget',
      (WidgetTester tester) async {
    // TODO: Implement test
    // Create the widget by telling the tester to build it
    await tester.pumpWidget(TextmarksPageView());

    //create the finders
    final idFinder = find.text('textmarks_page_view');

    expect(idFinder, findsOneWidget);
  });
}
