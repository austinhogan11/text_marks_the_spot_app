import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/textmark_card.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';

final User currentUser = FirebaseAuth.instance.currentUser;
CollectionReference textmarks = DataHandling().textmarks;
CollectionReference users = DataHandling().users;

class TextmarksStream extends StatelessWidget {
  final bool isSentStream;

  TextmarksStream({this.isSentStream});

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
        List<TextmarkCard> textmarkCards = [];

        if (isSentStream) {
          for (var textmark in textmarksDocs) {
            final sender = textmark['senderUID'];

            if (sender == currentUser.uid) {
              final date = textmark['textmarkDate'];
              final recipient = textmark['recipientUsername'];
              final locationNickname = textmark['locationNickname'];
              final textmarkCard = TextmarkCard(
                date: date,
                username: recipient,
                isSender: true,
                locationNickname: locationNickname,
              );
              textmarkCards.add(textmarkCard);
            }
          }
        } else {
          for (var textmark in textmarksDocs) {
            final recipient = textmark['recipientUID'];

            if (recipient == currentUser.uid) {
              final date = textmark['textmarkDate'];
              final sender = textmark['senderUsername'];
              final locationNickname = textmark['locationNickname'];
              final textmarkCard = TextmarkCard(
                date: date,
                username: sender,
                isSender: false,
                locationNickname: locationNickname,
              );
              textmarkCards.add(textmarkCard);
            }
          }
        }
        return ListView(
          children: textmarkCards,
        );
      },
    );
  }
}
