import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/components/textmark_stream.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';

class ReceivedTextmarksScreen extends StatefulWidget {
  static const String id = 'received_textmarks_screen';
  @override
  _ReceivedTextmarksScreenState createState() =>
      _ReceivedTextmarksScreenState();
}

class _ReceivedTextmarksScreenState extends State<ReceivedTextmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: CustomAppBar(
        title: 'Received Textmarks',
        icon: Icon(
          Icons.home,
          size: 30.0,
        ),
        iconFunction: () => Navigator.pushNamed(context, HomeScreen.id),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextmarksStream(
          isSentStream: false,
        ),
      ),
    );
  }
}
