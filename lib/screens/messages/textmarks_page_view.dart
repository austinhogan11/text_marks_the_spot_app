import 'package:flutter/cupertino.dart';
import 'package:text_marks_the_spot_app/screens/messages/sent_textmarks_screen.dart';
import 'package:text_marks_the_spot_app/screens/messages/received_textmarks_screen.dart';

class TextmarksPageView extends StatefulWidget {
  static const String id = 'textmarks_page_view';
  @override
  _TextmarksPageViewState createState() => _TextmarksPageViewState();
}

class _TextmarksPageViewState extends State<TextmarksPageView> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        ReceivedTextmarksScreen(),
        SentTextmarksScreen(),
      ],
    );
  }
}
