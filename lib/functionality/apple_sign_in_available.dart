import 'package:apple_sign_in/apple_sign_in.dart';

//Checks if sing in with apple is available to display the button on the UI
class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}
