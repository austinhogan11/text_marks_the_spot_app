import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/constants.dart';

/*
- Button widget + styling for login_screen buttons
- SignInButton requires an image, button text, and a function to handle sign in authentication.
 */
class CustomButton extends StatelessWidget {
  final String image;
  final Color color;
  final Color textColor;
  final String btnText;
  final double fontSize;
  final Function onTap;

  CustomButton(
      {this.image,
      this.btnText,
      this.fontSize,
      this.color,
      this.textColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: color,
      splashColor: kPrimaryColor,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (image != null)
              Image(image: AssetImage("assets/$image"), height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                btnText,
                style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
