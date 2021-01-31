import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/Screens/Map/map_screen.dart';
import 'package:testing_app/Screens/Welcome/welcome_screen.dart';
import 'package:testing_app/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testing_app/providers/app_state.dart';
import 'package:testing_app/providers/user.dart';

import 'Screens/Login/login_screen.dart';
import 'package:testing_app/Screens/home.dart';
import 'locators/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppStateProvider>.value(
        value: AppStateProvider(),
      ),
      ChangeNotifierProvider<UserProvider>.value(
        value: UserProvider.initialize(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriDriver',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return WelcomeScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return MyHomePage();
      default:
        return LoginScreen();
    }
  }
}
