import 'package:flutter/material.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/create_textmark_screen.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';
import 'package:text_marks_the_spot_app/functionality/geolocation/geolocation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  Widget buildTextmarkCreator(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        icon: kSettingsIconButton,
        iconFunction: () => Navigator.pushNamed(context, AccountScreen.id),
      ),
      backgroundColor: kAccentColor,
      body: Container(
        child: Stack(
            overflow: Overflow.visible,
          children: [
            FlutterMap(
            options: MapOptions(
              center: LatLng(51.5, -0.09),
              zoom: 13.0,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']
              ),
            ],
          ),
            Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.location_searching_sharp,
                          size: 55.0,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  CustomButton(
                    color: kPrimaryColor,
                    textColor: Colors.white,
                    btnText: 'Create a Text Mark',
                    fontSize: 22.5,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => CreateTextMark(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),]
      ),
      ),
    );
  }
}
