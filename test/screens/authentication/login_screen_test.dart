import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:text_marks_the_spot_app/functionality/authentication/apple_sign_in_available.dart';
import 'package:text_marks_the_spot_app/screens/authentication/login_screen.dart';

Widget testingLoginScreenWidget({Widget child}) {
  return MaterialApp(
    home: child,
  );
}

void main() {
  group('Widget Tetst for login_screen.dart', () {});
}
