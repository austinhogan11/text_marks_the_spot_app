import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:text_marks_the_spot_app/components/custom_button.dart';
import 'package:text_marks_the_spot_app/components/custom_app_bar.dart';
import 'package:text_marks_the_spot_app/constants.dart';
import 'package:text_marks_the_spot_app/screens/home/create_textmark_screen.dart';
import 'package:text_marks_the_spot_app/data/data_handling.dart';
import 'package:text_marks_the_spot_app/screens/account_settings/account_screen.dart';
import 'package:text_marks_the_spot_app/functionality/geolocation/geolocation.dart';
import 'package:text_marks_the_spot_app/screens/home/show_textmark_message.dart';
import 'package:text_marks_the_spot_app/screens/messages/textmarks_page_view.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildTextmarkCreator(BuildContext context) {
    return Container();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static LatLng _initialPosition;
  Set<Marker> _markers = new Set<Marker>();
  Set<Circle> _circles = new Set<Circle>();
  Marker currentMarker;
  Circle youCircle;
  Marker you;
  GeoPoint currentGeoPoint;
  LatLng currentCenter;
  double latitude = 0;
  double longitude = 0;
  double currentZoom = 15;
  CameraPosition cameraPosition;
  var _mapController;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Home",
        icon: kSettingsIconButton,
        iconFunction: () => Navigator.pushNamed(context, AccountScreen.id),
      ),
      backgroundColor: kAccentColor,
      body: Container(
        child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              (_initialPosition == null || this.cameraPosition == null)
                  ? CircularProgressIndicator()
                  : GoogleMap(
                      markers: _markers,
                      circles: _circles,
                      onLongPress: (LatLng coor) {
                        setState(() {
                          currentMarker == null
                              ? print("no current")
                              : _markers.remove(currentMarker);
                          this.currentGeoPoint =
                              new GeoPoint(coor.latitude, coor.longitude);
                          currentMarker = new Marker(
                              markerId: MarkerId("currentMarker"),
                              onTap: () {
                                _markers.removeWhere((element) =>
                                    element.markerId.value == "currentMarker");
                                _mapController.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                                currentCenter.latitude,
                                                currentCenter.longitude),
                                            zoom: currentZoom)));
                                setState(() {});
                              },
                              position: coor,
                              icon: BitmapDescriptor.defaultMarkerWithHue(100));
                        });
                        _markers.add(currentMarker);
                      },
                      mapType: MapType.normal,
                      onCameraMove: (CameraPosition position) {
                        setState(() {
                          currentCenter = position.target;
                          currentZoom = position.zoom;
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
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30.0, 0, 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RawMaterialButton(
                                elevation: 2.0,
                                fillColor: kPrimaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.location_searching_sharp,
                                    size: 45.0,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: CircleBorder(),
                                onPressed: () async {
                                  await getLocation();
                                  setState(() {
                                    _mapController.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(this.latitude,
                                                    this.longitude),
                                                zoom: 15.0)));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RawMaterialButton(
                                elevation: 2.0,
                                fillColor: kPrimaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Icon(
                                    Icons.message_sharp,
                                    size: 45.0,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: CircleBorder(),
                                onPressed: () {
                                  setLocation();
                                }),
                          ],
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        CustomButton(
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          btnText: 'Create Textmark',
                          onTap: () async {
                            String markerWasSent =
                                await showModalBottomSheet<String>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => CreateTextMark(
                                  coordinates: this.currentGeoPoint),
                            );
                            if (markerWasSent != null) {
                              // green marker is replaced with blue/red
                              _markers.remove(this.currentMarker);
                              this.currentMarker = null;
                              getMarkers();
                            }
                          },
                        ),
                      ],
                    ),
                  )),
            ]),
      ),
    );
  }

  void setLocation() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TextmarksPageView(),
        )).then((result) {
      getMarkers();

      if (result != null) {
        this.cameraPosition = CameraPosition(
          target: LatLng(result.latitude, result.longitude),
          zoom: 15.0,
        );

        _mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(result.latitude, result.longitude), zoom: 15.0)));

        this.currentCenter = LatLng(this.latitude, this.longitude);

        setState(() {
          _initialPosition = LatLng(this.latitude, this.longitude);
        });
      }
    });
  }

  Future<String> getLocation() async {
    var p = await determinePosition();

    this.latitude = p.latitude;
    this.longitude = p.longitude;


    setState(() {
      getMarkers();
      _initialPosition = LatLng(this.latitude, this.longitude);
    });

    this.cameraPosition = CameraPosition(
      target: _initialPosition,
      zoom: 15.0,
    );

    this.currentCenter = LatLng(this.latitude, this.longitude);

    _markers.removeWhere((element) => element.markerId.value == "You");
    _circles.removeWhere((element) => element.circleId.value == "youCircle");

    this.you = new Marker(
        markerId: new MarkerId("You"),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: "You"),
        icon: BitmapDescriptor.defaultMarkerWithHue(50));

    this.youCircle = new Circle(
      circleId: new CircleId("youCircle"),
      center: LatLng(latitude, longitude),
      fillColor: kPrimaryColor.withOpacity(0.1),
      radius: 805.0, // 1 mile
      strokeWidth: 1,
      strokeColor: kPrimaryColor,
    );

    _circles.add(youCircle);

    _markers.add(you);

    return "Success";
  }

  void getMarkers() async {
    final User loggedInUser = _auth.currentUser;

    CollectionReference textmarks = DataHandling().textmarks;
    QuerySnapshot firestoreTextMarks = await textmarks.get();

    GeoPoint markerCoordinates;
    String id;
    double hue;
    String user;
    bool isReceived = false;
    Set<Marker> newMarkers = new Set<Marker>();

    firestoreTextMarks.docs.forEach((map) {
      if (map.data().containsValue(loggedInUser.uid)) {
        isReceived = false;
        markerCoordinates = map["coordinates"];
        if (map["senderUID"] == loggedInUser.uid) {
          id = "Sent/" +
              loggedInUser.uid +
              "/" +
              markerCoordinates.latitude.toString() +
              "/" +
              markerCoordinates.longitude.toString();
          hue = 240;
          user = map["recipientUsername"];
        } else if (map["recipientUID"] == loggedInUser.uid) {
          id = "Received/" +
              loggedInUser.uid +
              "/" +
              markerCoordinates.latitude.toString() +
              "/" +
              markerCoordinates.longitude.toString();
          hue = 0;
          user = map["senderUsername"];
          isReceived = true;
        }

        String snippet = isReceived == true ? "Sent by ${map["senderUsername"]} on ${map["dateLabel"]}" :
        "Sent to ${map["recipientUsername"]} on ${map["dateLabel"]}";

        newMarkers.add(new Marker(
            markerId: new MarkerId(id),
            position:
                LatLng(markerCoordinates.latitude, markerCoordinates.longitude),
            infoWindow: InfoWindow(
                title: map["locationNickname"],
                snippet: user, //user that sends or receives the textmark
                onTap: !isReceived ||
                        (isReceived &&
                            markerIsWithinHalfAMile(
                                markerCoordinates.latitude,
                                markerCoordinates.longitude,
                                this.latitude,
                                this.longitude))
                    ? () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => ShowMessage(
                              markerCoordinates,
                              map["locationNickname"],
                              map["message"],
                              snippet),
                        );
                      }
                    : () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) => ShowMessage(
                              markerCoordinates,
                              "",
                              "You must be within half a mile to see a textmark's content",
                              ""),
                        );
                      }),
            icon: BitmapDescriptor.defaultMarkerWithHue(hue)));
      }
    });

    newMarkers.add(this.you);
    if (this.currentMarker != null) {
      newMarkers.add(this.currentMarker);
    }
    this._markers = newMarkers;
    setState(() {});
  }
}
