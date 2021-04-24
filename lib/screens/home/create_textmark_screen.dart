import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';

final User currentUser = FirebaseAuth.instance.currentUser;

class CreateTextMark extends StatefulWidget {
  final GeoPoint coordinates;

  const CreateTextMark({Key key, this.coordinates}) : super(key: key);

  @override
  _CreateTextMarkState createState() => _CreateTextMarkState();
}

var creationDate;
var expirationDate;
String _expirationOption;
String textmarkDateLabel;

class _CreateTextMarkState extends State<CreateTextMark> {
  @override
  void initState() {
    super.initState();
  }

  String textMarkRecipientUsername;
  String textMarkNickname;
  String textMarkMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height > 850.0)
          ? MediaQuery.of(context).size.height * .48
          : MediaQuery.of(context).size.height * .53,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 30.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                child: Text(
                  'Create a Textmark',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // RadiusSlider(),
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'nickname',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) => textMarkNickname = value,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'recipient username',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) => {
                            textMarkRecipientUsername = value,
                          }),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      hintText: 'Message',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) => textMarkMessage = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ExpirationDropdown(),
                  SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    btnText: 'Send',
                    color: Colors.white,
                    textColor: kPrimaryColor,
                    onTap: () {
                      print(this.textMarkMessage);
                      bool isBlank1 =
                          this.textMarkMessage?.trim()?.isEmpty ?? true;
                      bool isBlank2 =
                          this.textMarkRecipientUsername?.trim()?.isEmpty ??
                              true;
                      bool isBlank3 =
                          this.textMarkNickname?.trim()?.isEmpty ?? true;
                      if (isBlank1 == true ||
                          isBlank2 == true ||
                          isBlank3 == true) {
                        // empty textmark
                        return;
                      }
                      creationDate = DateTime.now();
                      textmarkDateLabel =
                          creationDate.toString().substring(5, 10);
                      if (_expirationOption == '30 days') {
                        expirationDate =
                            creationDate.add(new Duration(days: 30));
                      } else if (_expirationOption == '1 year') {
                        expirationDate =
                            creationDate.add(new Duration(days: 365));
                      } else {
                        expirationDate =
                            creationDate.add(new Duration(days: 36500));
                      }
                      print(
                          "Current Date: $creationDate\n ExpirationDate: $expirationDate");
                      DataHandling()
                          .saveTextMark(
                              creationDate,
                              expirationDate,
                              textmarkDateLabel,
                              currentUser.uid,
                              textMarkRecipientUsername,
                              widget.coordinates,
                              textMarkNickname,
                              textMarkMessage)
                          .then(
                            (value) => Navigator.pop(context, "Sent"),
                          );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpirationDropdown extends StatefulWidget {
  @override
  _ExpirationDropdownState createState() => _ExpirationDropdownState();
}

class _ExpirationDropdownState extends State<ExpirationDropdown> {
  // String _chosenValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      focusColor: Colors.white,
      dropdownColor: kAccentColor,
      value: _expirationOption,
      elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.white,
      items: <String>[
        'No Expiration',
        '30 days',
        '1 year',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
      hint: Center(
        child: Text(
          "Choose a message duration",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          _expirationOption = value;
        });
      },
    );
  }
}
