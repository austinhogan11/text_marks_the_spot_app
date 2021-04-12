import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:text_marks_the_spot_app/functionality/geolocation/geolocation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Testing for geolocation.dart, based on geolocator package', () {
    test('geolocation ...', () async {
      final testingPosition = await determinePosition();
    });
  });
}
