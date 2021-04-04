import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_alert_dialog.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';

class TextmarkCard extends StatelessWidget {
  final String textmarkID;
  final String date;
  final String username;
  final bool isSender;
  final String locationNickname;
  final GeoPoint coordinates;

  TextmarkCard({
    this.textmarkID,
    this.date,
    this.username,
    this.isSender,
    this.locationNickname,
    this.coordinates,
  });

  _confirmTextmarkDeletion(BuildContext context, String tmNickname) {
    var baseDialog = CustomAlertDialog(
        title: "Delete Textmark:",
        content: "Are you sure you would like to delete $tmNickname?",
        confirmOnPressed: () {
          DataHandling().deleteTextMark(textmarkID);
          Navigator.pop(context);
        },
        cancelOnPressed: () => Navigator.pop(context),
        confirm: "Delete",
        cancel: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          date,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        title: Text("$locationNickname"),
        subtitle: Text(username),
        // trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.pop(context, this.coordinates);
        },
        onLongPress: () => _confirmTextmarkDeletion(context, locationNickname),
        // TODO: Update Markers when deleting
      ),
    );
  }
}
