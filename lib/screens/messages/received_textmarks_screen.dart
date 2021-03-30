import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/components/textmark_cards.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';

class ReceivedTextmarksScreen extends StatefulWidget {
  static const String id = 'received_textmarks_screen';
  @override
  _ReceivedTextmarksScreenState createState() =>
      _ReceivedTextmarksScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final User loggedInUser = _auth.currentUser;
CollectionReference textmarks = DataHandling().textmarks;
CollectionReference users = DataHandling().users;

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
        child: ReceivedTextmarksStream(),
      ),
    );
  }
}

class ReceivedTextmarksStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: textmarks.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
        final textmarksDocs = snapshot.data.docs;
        List<ReceivedTextmarkCard> textmarkCards = [];
        for (var textmark in textmarksDocs) {
          final recipient = textmark['recipientUID'];

          if (recipient == loggedInUser.uid) {
            final date = textmark['textmarkDate'];
            final sender = textmark['senderUsername'];
            final locationNickname = textmark['locationNickname'];
            final textmarkCard = ReceivedTextmarkCard(
              date: date,
              sender: sender,
              locationNickname: locationNickname,
            );
            textmarkCards.add(textmarkCard);
          }
        }
        return ListView(
          children: textmarkCards,
        );
      },
    );
  }
}
