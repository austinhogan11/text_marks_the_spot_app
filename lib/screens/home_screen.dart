import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/create_textmark_screen.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';
import 'package:text_marks_the_spot_app/functionality/geolocation/geolocation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import '../functionality/geolocation/geolocation.dart';
import '../functionality/geolocation/geolocation.dart';
import '../functionality/geolocation/geolocation.dart';
import '../functionality/geolocation/geolocation.dart';
import '../functionality/geolocation/geolocation.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();

  }

class _HomeScreenState extends State<HomeScreen>{

  var message = "";
  String latitude = "";
  String longitude = "";

  double l = 52.5;
  double ll = -0.18;

  Widget buildTextmarkCreator(BuildContext context) {
    return Container();
  }

  MapController _controller = new MapController();

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
            new FlutterMap(
              mapController: _controller,
              options: new MapOptions(
                center: LatLng(l, ll),
                zoom: 10.0,
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
                        onPressed: () {getLocation();},
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

  void getLocation() async {
    var p = await determinePosition();


    latitude = "$l";
    longitude = "$ll";

    print(p.latitude);
    print(p.longitude);

    setState(() {
      l = p.latitude;
      ll = p.longitude;
      message = "Works";
      _controller.onReady.then((result){
        _controller.move(LatLng(p.latitude,p.longitude), 10);
      });

    });

  }
}
