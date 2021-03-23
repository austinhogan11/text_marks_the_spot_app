import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/create_textmark_screen.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';
import 'package:text_marks_the_spot_app/functionality/geolocation/geolocation.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong/latlong.dart';

import '../functionality/geolocation/geolocation.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// TODO: Add button to navigate to textmarks screen

class _HomeScreenState extends State<HomeScreen> {
  Widget buildTextmarkCreator(BuildContext context) {
    return Container();
  }

  String snippet;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static LatLng _initialPosition;
  Set<Marker> _markers = new Set<Marker>();
  Marker currentMarker;
  GeoPoint currentGeoPoint;
  LatLng currentCenter;
  double latitude = 0;
  double longitude = 0;
  double currentZoom = 15;
  CameraPosition cameraPosition;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Completer<GoogleMapController> _controller = new Completer();

  var _mapController;

  _onMapCreated(GoogleMapController controller) async {
    getMarkers();
    setState(() {
      _controller.complete(controller);
    });
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
            alignment: Alignment.center,
            children: [
              _initialPosition == null
                  ? CircularProgressIndicator()
                  : GoogleMap(
                      markers: _markers,
                      onLongPress: (LatLng coor) {
                        setState(() {
                          currentMarker == null
                              ? print("no current")
                              : _markers.remove(currentMarker);
                          currentMarker = new Marker(
                              markerId: MarkerId(coor.toString()),
                              position: coor,
                              onTap: () {
                                print("eeeee ${coor}");
                              },
                              infoWindow: InfoWindow(
                                  title: "",
                                  snippet: "",
                                  onTap: () {
                                    print("eeeee ${coor}");
                                  }),
                              icon: BitmapDescriptor.defaultMarker);
                        });
                        currentGeoPoint =
                            new GeoPoint(coor.latitude, coor.longitude);
                        _markers.add(currentMarker);
                      },
                      mapType: MapType.hybrid,
                      onCameraMove: (CameraPosition position) {
                        setState(() {
                          currentCenter = position.target;
                        });
                      },
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      initialCameraPosition: this.cameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                        getMarkers();
                        setState(() {});
                      },
                    ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
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
                              onPressed: () {
                                getLocation();
                                _mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                                this.latitude, this.longitude),
                                            zoom: 15.0)));
                              },
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
                              builder: (BuildContext context) => CreateTextMark(
                                  coordinates: this.currentGeoPoint),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
            ]),
      ),
    );
  }

  void getLocation() async {
    var p = await determinePosition();
    this.latitude = p.latitude;
    this.longitude = p.longitude;

    setState(() {
      _initialPosition = LatLng(p.latitude, p.longitude);
    });

    this.cameraPosition = CameraPosition(
      target: _initialPosition,
      zoom: 15.0,
    );

    // _markers.removeWhere((element) => element.markerId.toString() == "You");

    _markers.add(new Marker(
        markerId: new MarkerId("You"),
        position: LatLng(latitude, longitude),
        onTap: () {
          print("OOOOOOOO");
        },
        infoWindow: InfoWindow(
            title: "You",
            onTap: () {
              print("OOOOOOOO");
            }),
        icon: BitmapDescriptor.defaultMarkerWithHue(50)));
  }

  void getMarkers() async {
    final User loggedInUser = _auth.currentUser;

    CollectionReference textmarks = DataHandling().textmarks;
    QuerySnapshot firestoreTextMarks = await textmarks.get();

    CollectionReference users = DataHandling().users;
    QuerySnapshot firestoreUsers = await users.get();

    GeoPoint g;
    String id;
    double hue;
    QueryDocumentSnapshot user;

    firestoreTextMarks.docs.forEach((map) {
      if (map.data().containsValue(loggedInUser.uid)) {
        g = map["coordinates"];
        if (map["senderUID"] == loggedInUser.uid) {
          id = "Sent/" +
              loggedInUser.uid +
              "/" +
              g.latitude.toString() +
              "/" +
              g.longitude.toString();
          hue = 240;
          user = firestoreUsers.docs.firstWhere(
              (element) => element.id.toString() == map["recipientUID"]);
        } else if (map["recipientUID"] == loggedInUser.uid) {
          id = "Received/" +
              loggedInUser.uid +
              "/" +
              g.latitude.toString() +
              "/" +
              g.longitude.toString();
          hue = 0;
          user = firestoreUsers.docs.firstWhere(
              (element) => element.id.toString() == map["senderUID"]);
        }
        _markers.add(new Marker(
            markerId: new MarkerId(id),
            position: LatLng(g.latitude, g.longitude),
            onTap: () {
              print("OOOOOOOO");
            },
            infoWindow: InfoWindow(
                title: map["locationNickname"],
                snippet:
                    user["username"], //user that sends or receives the textmark
                onTap: () {
                  print("OOOOOOOO");
                }),
            icon: BitmapDescriptor.defaultMarkerWithHue(hue)));
        setState(() {
          // print(_markers);
        });
      }
    });
  }
}
