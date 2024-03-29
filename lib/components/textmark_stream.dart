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

        final DateTime currentDate = DateTime.now();

        for (var textmark in textmarksDocs) {
          final user =
              (isSentStream) ? textmark['senderUID'] : textmark['recipientUID'];

          if (user == currentUser.uid) {
            final Timestamp creationTS = textmark['creationDate'];
            final DateTime creationDate = creationTS.toDate();
            final Timestamp expirationTS = textmark['expirationDate'];
            final DateTime expirationDate = expirationTS.toDate();
            print(
                "Creation: $creationDate Expiration: $expirationDate Current Date: $currentDate");
            if (expirationDate.isAtSameMomentAs(currentDate) ||
                expirationDate.isBefore(currentDate)) {
              DataHandling().deleteTextMark(textmark.id);
            } else {
              final textmarkCard = TextmarkCard(
                textmarkID: textmark.id,
                dateLabel: textmark['dateLabel'],
                creationDate: creationDate,
                expirationDate: expirationDate,
                username: (isSentStream)
                    ? textmark['recipientUsername']
                    : textmark['senderUsername'],
                isSender: isSentStream,
                locationNickname: textmark['locationNickname'],
                coordinates: textmark['coordinates'],
              );
              // textmarkCards.add(textmarkCard);
              textmarkCards.insert(0, textmarkCard);
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
