import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testing_app/components/rounded_search_field.dart';

import '../../constants.dart';
import 'components/searchbar.dart';

// ignore: must_be_immutable
class MainMapScreen extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController newGoogleMapController;

  Position currentPosition;

  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // initial position
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleMapController = controller;

                locatePosition();
              },
            ),
            Positioned(
              top: 24,
              left: 10,
              child: FloatingActionButton(
                elevation: 5.0,
                onPressed: () {
                  print('button click');
                },
                foregroundColor: kPrimaryColor,
                backgroundColor: Colors.white,
                child: new Icon(Icons.menu),
              ),
            ),
            Positioned(
              top: 25,
              right: 10,
              child: FloatingActionButton(
                elevation: 5.0,
                onPressed: () {
                  print('button click');
                },
                foregroundColor: kPrimaryColor,
                backgroundColor: Colors.white,
                child: new Icon(Icons.chat_rounded),
              ),
            ),
            Positioned(
              left: 50 * 1.5,
              right: 50 * 1.5,
              top: 13 * 2.25,
              child: Column(
                children: [
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                          spreadRadius: 0.3,
                          offset: Offset(0.9, 0.9),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: TextField(
                          controller: TextEditingController(text: "Where to?"),
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 15.0),
                            suffixIcon: Material(
                              elevation: 0.0,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              child: Icon(
                                Icons.search,
                                color: kPrimaryColor,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 25 * 0.5,
              right: 50 * 0.5,
              bottom: 50 * 1.5,
              child: Column(
                children: [
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0,
                          spreadRadius: 0.3,
                          offset: Offset(0.9, 0.9),
                        ),
                      ],
                    ),
                    // child: Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 100.0),
                    //   child: Material(
                    //     elevation: 5.0,
                    //     borderRadius: BorderRadius.all(Radius.circular(00.0)),
                    //     child: TextField(
                    //       controller: TextEditingController(text: "Where to?"),
                    //       cursorColor: Colors.white,
                    //       decoration: InputDecoration(
                    //         contentPadding: EdgeInsets.symmetric(
                    //             horizontal: 32.0, vertical: 14.0),
                    //         suffixIcon: Material(
                    //           elevation: 2.0,
                    //           borderRadius: BorderRadius.all(
                    //             Radius.circular(30.0),
                    //           ),
                    //           child: Icon(
                    //             Icons.search,
                    //             color: Colors.black,
                    //           ),
                    //         ),
                    //         border: InputBorder.none,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

class LocationData {}
