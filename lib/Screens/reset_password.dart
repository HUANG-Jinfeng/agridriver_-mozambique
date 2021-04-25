import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/Screens/Login/components/login_background.dart';
import 'package:testing_app/Screens/Map/map_screen.dart';
import 'package:testing_app/Screens/Signup/signup_screen.dart';
import 'package:testing_app/components/already_have_an_account_acheck.dart';
import 'package:testing_app/components/rounded_button.dart';
import 'package:testing_app/components/rounded_input_field.dart';
import 'package:testing_app/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testing_app/helpers/screen_navigation.dart';
import 'package:testing_app/providers/user.dart';
import 'package:testing_app/Screens/home.dart';

import '../constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    Key key,
  }) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return MyHomePage();
        //   AlertDialog(
        //   title: Text('Login Successful'),
        //   content: SingleChildScrollView(
        //     child: ListBody(
        //       children: <Widget>[
        //         Text('You have been logged'),
        //         Text('This dialogue will be chaned to a redirect'),
        //       ],
        //     ),
        //   ),
        //   actions: <Widget>[
        //     TextButton(
        //       child: Text('Enter'),
        //       onPressed: () {
        //         Navigator.push(context, MaterialPageRoute(builder: (context) {
        //           return MapScreen();
        //         }));
        //       },
        //     ),
        //   ],
        // );
      },
    );
  }

  String login = "SEND LINK";
  bool sent = false;
  User user = FirebaseAuth.instance.currentUser;
  Future<void> _showMyLogFDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Login has failed due to invalid inputs'),
                Text('Retry or sign up if you dont have an account'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                setState(() {
                  login = "LOG IN";
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    final _key = GlobalKey<ScaffoldState>();
    TextEditingController oldpassword = TextEditingController();
    TextEditingController newpassword = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
    Size size = MediaQuery.of(context).size;
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "RESET PASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  "A password reset link will",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "be sent to your email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.25,
                ),
                SizedBox(height: size.height * 0.02),
                // TextFormField(
                //   obscureText: true,
                //   controller: oldpassword,
                //   cursorColor: kPrimaryColor,
                //   decoration: InputDecoration(
                //     hintText: "Old Password",
                //     errorText: checkCurrentPasswordValid
                //         ? null
                //         : "Please double check your current password",
                //     icon: Icon(
                //       Icons.lock_open,
                //       color: kPrimaryColor,
                //     ),
                //     border: InputBorder.none,
                //   ),
                // ),
                // TextFormField(
                //   obscureText: true,
                //   controller: newpassword,
                //   cursorColor: kPrimaryColor,
                //   decoration: InputDecoration(
                //     hintText: "New Password",
                //     icon: Icon(
                //       Icons.lock,
                //       color: kPrimaryColor,
                //     ),
                //     border: InputBorder.none,
                //   ),
                // ),
                // TextFormField(
                //   obscureText: true,
                //   controller: oldpassword,
                //   cursorColor: kPrimaryColor,
                //   validator: (value) {
                //     return newpassword.text == value
                //         ? null
                //         : "Password does not match";
                //   },
                //   decoration: InputDecoration(
                //     hintText: "Confirm Password",
                //     icon: Icon(
                //       Icons.lock_rounded,
                //       color: kPrimaryColor,
                //     ),
                //     border: InputBorder.none,
                //   ),
                // ),
                // SizedBox(height: size.height * 0.04),
                RoundedButton(
                  text: login,
                  press: sent ? null : () => sendEmail(),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendEmail() async {
    setState(() {
      login = "EMAIL SENT";
      sent = true;
    });
    // if (_loginFormKey.currentState.validate()) {
    //   user.updatePassword(newpassword.text);
    //   setState(() {
    //     login = "SEND LINK";
    //   });
    //}
    await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email);
  }
}
