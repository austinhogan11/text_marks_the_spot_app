import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/textmark_card.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';

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
        User currentUser = FirebaseAuth.instance.currentUser;
        List<TextmarkCard> textmarkCards = [];

        for (var textmark in textmarksDocs) {
          final user =
              (isSentStream) ? textmark['senderUID'] : textmark['recipientUID'];

          if (user == currentUser.uid) {
            final textmarkID = textmark.id;
            final date = textmark['textmarkDate'];
            final externalUser = (isSentStream)
                ? textmark['recipientUsername']
                : textmark['senderUsername'];
            final locationNickname = textmark['locationNickname'];
            final coordinates = textmark['coordinates'];
            final textmarkCard = TextmarkCard(
              textmarkID: textmarkID,
              date: date,
              username: externalUser,
              isSender: isSentStream,
              locationNickname: locationNickname,
              coordinates: coordinates,
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
