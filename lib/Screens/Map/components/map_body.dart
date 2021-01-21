import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testing_app/Screens/Chat/chat_screen.dart';
import 'package:testing_app/constants.dart';

class MapBody extends StatefulWidget {
  @override
  State<MapBody> createState() => MapBodyState();
}

class MapBodyState extends State<MapBody> {
  Completer<GoogleMapController> _controller = Completer();
  MapType type;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: topPosition,
            left: leftPosition,
            child: FloatingActionButton(
              elevation: 5.0,
              foregroundColor: kPrimaryColor,
              backgroundColor: Colors.white,
              child: new Icon(Icons.menu),
              onPressed: () {
                print('button click to menu');
              },
            ),
          ),
          Positioned(
            top: topPosition,
            right: rightPosition,
            child: FloatingActionButton(
              elevation: 5.0,
              foregroundColor: kPrimaryColor,
              backgroundColor: Colors.white,
              child: new Icon(Icons.chat_rounded),
              onPressed: () {
                print('button click to chat');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatMainPage(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: leftPosition * 1.5,
            right: rightPosition * 1.5,
            top: topPosition * 2.25,
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
    );
  }
}
