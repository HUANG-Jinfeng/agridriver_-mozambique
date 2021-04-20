import 'package:flutter/material.dart';
import 'package:testing_app/helpers/style.dart';
import 'package:testing_app/widgets/loading.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/login_bottom.png",
              width: 200,
            ),
            Loading(),
          ],
        ));
  }
}
