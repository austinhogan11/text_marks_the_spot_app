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
  final Function onTap;

  CustomButton({
    this.image,
    this.btnText,
    this.color,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(kAccentColor),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.5),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (image != null)
              Image(
                image: AssetImage("assets/$image"),
                height: 25.0,
              ),
            if (image != null) SizedBox(width: 10.0),
            Text(
              btnText,
              style: TextStyle(
                  fontSize: 17.0,
                  color: textColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
