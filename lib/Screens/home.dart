import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_app/Screens/Chat/chat_screen.dart';
import 'package:testing_app/Screens/reset_password.dart';
import 'package:testing_app/helpers/constants.dart';
import 'package:testing_app/helpers/screen_navigation.dart';
import 'package:testing_app/helpers/style.dart';
import 'package:testing_app/providers/app_state.dart';
import "package:google_maps_webservice/places.dart";
import 'package:testing_app/providers/user.dart';
import 'package:testing_app/screens/splash.dart';
import 'package:testing_app/widgets/custom_text.dart';
import 'package:testing_app/widgets/destination_selection.dart';
import 'package:testing_app/widgets/driver_found.dart';
import 'package:testing_app/widgets/loading.dart';
import 'package:testing_app/widgets/payment_method_selection.dart';
import 'package:testing_app/widgets/pickup_selection_widget.dart';
import 'package:testing_app/widgets/trip_draggable.dart';

import '../helpers/style.dart';
import 'package:testing_app/Screens/Login/login_screen.dart';
import 'package:testing_app/constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _deviceToken();
  }

  _deviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);

    if (_user.userModel?.token != preferences.getString('token')) {
      Provider.of<UserProvider>(context, listen: false).saveDeviceToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    String img = userProvider.userModel?.imageID ?? 'images/imageName';
    Future<String> getImage() async {
      final ref = FirebaseStorage.instance.ref().child('$img');
// no need of the file extension, the name will do fine.
      var url = await ref.getDownloadURL();
      //print(url);
      return url;
    }

    return SafeArea(
      child: Scaffold(
        key: scaffoldState,
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                //margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  //borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                currentAccountPicture: FutureBuilder(
                    future: getImage(),
                    builder: (context, snapshot) {
                      return CircleAvatar(
                        backgroundImage: snapshot.hasData
                            ? NetworkImage(snapshot.data)
                            : AssetImage("assets/images/user_images.jpg"),
                      );
                    }),
                // CircleAvatar(
                //   backgroundImage: (userProvider.userModel.imageID != null)
                //       ? NetworkImage(imageUrl)
                //       : AssetImage("assets/images/user_images.jpg"),
                // ),
                accountName: CustomText(
                  text: userProvider.userModel?.name ?? "This is null",
                  size: 25,
                  weight: FontWeight.bold,
                  color: Colors.black87,
                ),
                accountEmail: CustomText(
                  text: userProvider.userModel?.email ?? "This is null",
                  color: Colors.black54,
                ),
                onDetailsPressed: () {
                  print('onDetailsPressed');
                },
                arrowColor: Colors.white,
              ),
              ListTile(
                leading: Icon(Icons.vpn_key_rounded),
                title: CustomText(text: "Reset Password"),
                onTap: () {
                  changeScreenReplacement(context, ResetPassword());
                },
              ),
              Divider(),
              // ListTile(
              //   leading: Icon(Icons.settings_applications_rounded),
              //   title: CustomText(text: "Setting"),
              //   onTap: () {},
              // ),
              // Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app_rounded),
                title: CustomText(text: "Log out"),
                onTap: () {
                  userProvider.signOut();
                  changeScreenReplacement(context, LoginScreen());
                },
              ),
              Divider(),
            ],
          ),
        ),
        body: Stack(
          children: [
            MapScreen(scaffoldState),
            // Visibility(
            //   visible: appState.show == Show.DRIVER_FOUND,
            //   child: Positioned(
            //     top: 60,
            //     left: 15,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 30),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Container(
            //             child: appState.driverArrived
            //                 ? Container(
            //                     color: green,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(16),
            //                       child: CustomText(
            //                         text: "Meet driver at the pick up location",
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   )
            //                 : Container(
            //                     color: primary,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(16),
            //                       child: CustomText(
            //                         text: "Meet driver at the pick up location",
            //                         weight: FontWeight.w300,
            //                         color: white,
            //                       ),
            //                     ),
            //                   ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Visibility(
            //   visible: appState.show == Show.TRIP,
            //   child: Positioned(
            //     top: 60,
            //     left: MediaQuery.of(context).size.width / 7,
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 30),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Container(
            //             child: Container(
            //               color: primary,
            //               child: Padding(
            //                   padding: const EdgeInsets.all(16),
            //                   child: RichText(
            //                       text: TextSpan(children: [
            //                     TextSpan(
            //                         text: "You\'ll reach your desiation in \n",
            //                         style:
            //                             TextStyle(fontWeight: FontWeight.w300)),
            //                     TextSpan(
            //                         text:
            //                             appState.routeModel?.timeNeeded?.text ??
            //                                 "",
            //                         style: TextStyle(fontSize: 22)),
            //                   ]))),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // ANCHOR Draggable
            // Visibility(
            //     visible: appState.show == Show.DESTINATION_SELECTION,
            //     child: DestinationSelectionWidget()),
            // ANCHOR PICK UP WIDGET
            // Visibility(
            //   visible: appState.show == Show.PICKUP_SELECTION,
            //   child: PickupSelectionWidget(
            //     scaffoldState: scaffoldState,
            //   ),
            // ),
            // //  ANCHOR Draggable PAYMENT METHOD
            // Visibility(
            //     visible: appState.show == Show.PAYMENT_METHOD_SELECTION,
            //     child: PaymentMethodSelectionWidget(
            //       scaffoldState: scaffoldState,
            //     )),
            // //  ANCHOR Draggable DRIVER
            // Visibility(
            //     visible: appState.show == Show.DRIVER_FOUND,
            //     child: DriverFoundWidget()),
            //
            // //  ANCHOR Draggable DRIVER
            // Visibility(
            //     visible: appState.show == Show.TRIP, child: TripWidget()),
          ],
        ),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  MapScreen(this.scaffoldState);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return appState.center == null
        ? Loading()
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: appState.center, zoom: 15),
                onMapCreated: appState.onCreate,
                myLocationEnabled: true,
                padding: EdgeInsets.only(
                  top: topPosition * 12.7,
                  // bottom: bottomPosition * 8,
                  right: rightPosition,
                ),
                mapType: MapType.normal,
                compassEnabled: true,
                rotateGesturesEnabled: true,
                markers: appState.markers,
                onCameraMove: appState.onCameraMove,
                polylines: appState.poly,
              ),
              Positioned(
                top: topPosition,
                left: leftPosition * 0.1,
                child: RaisedButton(
                  child: Icon(Icons.menu),
                  color: Colors.white,
                  textColor: kPrimaryColor,
                  splashColor: kPrimaryLightColor,
                  elevation: 15.0,
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('button click to menu screen');
                    scaffoldSate.currentState.openDrawer();
                  },
                ),
              ),
              Positioned(
                top: topPosition,
                right: rightPosition * 0.1,
                child: RaisedButton(
                  child: Icon(Icons.chat),
                  color: Colors.white,
                  textColor: kPrimaryColor,
                  splashColor: kPrimaryLightColor,
                  elevation: 15.0,
                  padding: EdgeInsets.all(10),
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print('button click to chat screen');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatMainPage()),
                    );
                  },
                ),
              ),
//              Positioned(
//                bottom: 60,
//                right: 0,
//                left: 0,
//                height: 60,
//                child: Visibility(
//                  visible: appState.routeModel != null,
//                  child: Padding(
//                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//                    child: Container(
//                      color: Colors.white,
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          FlatButton.icon(
//                              onPressed: null,
//                              icon: Icon(Icons.timer),
//                              label: Text(
//                                  appState.routeModel?.timeNeeded?.text ?? "")),
//                          FlatButton.icon(
//                              onPressed: null,
//                              icon: Icon(Icons.flag),
//                              label: Text(
//                                  appState.routeModel?.distance?.text ?? "")),
//                          FlatButton(
//                              onPressed: () {},
//                              child: CustomText(
//                                text:
//                                    "\$${appState.routeModel?.distance?.value == null ? 0 : appState.routeModel?.distance?.value / 500}" ??
//                                        "",
//                                color: Colors.deepOrange,
//                              ))
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              ),
            ],
          );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
}
