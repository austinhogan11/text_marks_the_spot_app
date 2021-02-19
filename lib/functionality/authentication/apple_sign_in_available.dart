import 'package:apple_sign_in/apple_sign_in.dart';

//Checks if sign in with apple is available on the device currently accessing the application.
class AppleSignInAvailable {
  AppleSignInAvailable(this.isAvailable);
  final bool isAvailable;

  static Future<AppleSignInAvailable> check() async {
    return AppleSignInAvailable(await AppleSignIn.isAvailable());
  }
}
