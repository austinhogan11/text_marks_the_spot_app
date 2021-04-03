import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/screens/home/home_screen.dart';

final User currentUser = FirebaseAuth.instance.currentUser;

class CreateTextMark extends StatefulWidget {
  final GeoPoint coordinates;

  const CreateTextMark({Key key, this.coordinates}) : super(key: key);

  @override
  _CreateTextMarkState createState() => _CreateTextMarkState();
}

var currentDate;
String textmarkDate;

class _CreateTextMarkState extends State<CreateTextMark> {
  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    textmarkDate = currentDate.toString().substring(5, 10);
  }

  @override
  String textMarkRecipientUsername;
  String textMarkNickname;
  String textMarkMessage;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF757575),
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
            // padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 0, 20.0),
                  child: Text(
                    'Create a Text Mark:',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30.0),
                    child: Column(
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
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  btnText: 'Send',
                  fontSize: 15.0,
                  color: Colors.white,
                  textColor: kPrimaryColor,
                  onTap: () => {
                    DataHandling().saveTextMark(
                        textmarkDate,
                        currentUser.uid,
                        textMarkRecipientUsername,
                        widget.coordinates,
                        textMarkNickname,
                        textMarkMessage),
                    Navigator.pushNamed(context, HomeScreen.id),
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RadiusSlider extends StatefulWidget {
  @override
  _RadiusSliderState createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {
  double radiusValue = 0.5;
  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.white,
      inactiveColor: kAccentColor,
      value: radiusValue,
      min: 0.0,
      max: 1.0,
      divisions: 4,
      label: '${radiusValue.toString()}mi',
      onChanged: (updatedRadius) {
        setState(
          () {
            radiusValue = updatedRadius;
          },
        );
      },
    );
  }
}
