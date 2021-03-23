import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/home_screen.dart';

class ReceivedTextmarksScreen extends StatefulWidget {
  static const String id = 'received_textmarks_screen';
  @override
  _ReceivedTextmarksScreenState createState() =>
      _ReceivedTextmarksScreenState();
}

// TODO: Query Received Textmark data
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
          child: ListView(
            children: const <Widget>[
              Card(
                child: ListTile(
                  leading: Text(
                    '3/23',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  title: Text('Textmark from Austin11'),
                  subtitle: Text('New Campus Burger Joint'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    '3/23',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  title: Text('Textmark from ash03'),
                  subtitle: Text('Kroger by the house'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    '3/22',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  title: Text('Textmark from ash03'),
                  subtitle: Text('Campus Rec Center'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text(
                    '3/21',
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  title: Text('Textmark from NotElon'),
                  subtitle: Text('Mars'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
        ));
  }
}
