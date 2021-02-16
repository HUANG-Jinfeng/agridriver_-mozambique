import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/helpers/constants.dart';
import 'package:testing_app/helpers/style.dart';
import 'package:testing_app/providers/app_state.dart';
import 'package:testing_app/providers/user.dart';

import 'custom_text.dart';

class PaymentMethodSelectionWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  const PaymentMethodSelectionWidget({Key key, this.scaffoldState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStateProvider appState = Provider.of<AppStateProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.3,
      builder: (BuildContext context, myscrollController) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                  color: grey.withOpacity(.8),
                  offset: Offset(3, 2),
                  blurRadius: 7)
            ],
          ),
          child: ListView(
            controller: myscrollController,
            children: [
              SizedBox(height: 10),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: CustomText(
              //     text: "How do you want to pay,\n\$${appState.ridePrice}",
              //     size: 24,
              //     weight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: Colors.red[200],
                    //     border: Border.all(
                    //         color: Colors.blue.withOpacity(0.3), width: 1.5),
                    //     borderRadius: BorderRadius.all(
                    //       Radius.circular(20.0),
                    //     ),
                    //   ),
                    //   child: FlatButton.icon(
                    //     onPressed: () {
                    //       scaffoldState.currentState.showSnackBar(
                    //         SnackBar(
                    //           content: Text("Method not available!"),
                    //         ),
                    //       );
                    //     },
                    //     icon: Icon(
                    //       Icons.credit_card,
                    //       color: Colors.white,
                    //     ),
                    //     label: CustomText(
                    //       text: "With Card",
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red[200],
                        border: Border.all(color: Colors.red[200], width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                        ),
                        label: CustomText(
                          text: "With Cash",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              appState.lookingForDriver
                  ? Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Container(
                        color: white,
                        child: ListTile(
                          title: SpinKitWave(
                            color: kPrimaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15.0,
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () async {
                            appState.requestDriver(
                                distance: appState.routeModel.distance.toJson(),
                                user: userProvider.userModel,
                                lat: appState.pickupCoordinates.latitude,
                                lng: appState.pickupCoordinates.longitude,
                                context: context);
                            appState.changeMainContext(context);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ), //this right here
                                  child: Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SpinKitWave(
                                            color: kPrimaryColor,
                                            size: 30,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Looking for a driver",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          LinearPercentIndicator(
                                            lineHeight: 4,
                                            animation: true,
                                            animationDuration: 100000,
                                            percent: 1,
                                            backgroundColor:
                                                Colors.grey.withOpacity(0.2),
                                            progressColor: kPrimaryColor,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  appState.cancelRequest();
                                                  scaffoldState.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          "Request cancelled!"),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          color: kPrimaryColor,
                          child: Text(
                            "Request",
                            style: TextStyle(
                              color: white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
