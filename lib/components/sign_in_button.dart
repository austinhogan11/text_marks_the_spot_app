import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';

class SignInButton extends StatelessWidget {
  final String image;
  final String buttonText;
  final Function signInFunction;

  SignInButton({this.image, this.buttonText, this.signInFunction});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.white,
      splashColor: kPrimaryColor,
      onPressed: signInFunction,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/$image"), height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
