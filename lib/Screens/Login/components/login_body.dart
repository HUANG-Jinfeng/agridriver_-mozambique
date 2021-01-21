import 'package:flutter/material.dart';
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

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key,
  }) : super(key: key);

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have been logged'),
                Text('This dialogue will be chaned to a redirect'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MapScreen();
                }));
              },
            ),
          ],
        );
      },
    );
  }

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
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    Size size = MediaQuery.of(context).size;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return LoginBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOG IN",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.02),
              RoundedInputField(
                hintText: "Email",
                onChanged: (value) {},
                cont: email,
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                cont: password,
              ),
              // Text(
              //   "Remember me",
              //   style: TextStyle(
              //     color: kPrimaryNoteColor,
              //     fontSize: 14,
              //   ),
              // ),
              SizedBox(height: size.height * 0.04),
              RoundedButton(
                text: "LOG IN",
                press: () {
                  if (_loginFormKey.currentState.validate()) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email.text, password: password.text)
                        .then((currentUser) => firestore
                            .collection("users")
                            .doc(currentUser.user.uid)
                            .get()
                            .then(
                              (DocumentSnapshot result) =>
                                  // print("User Logged in"),
                                  _showMyDialog(context),
                            )
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => HomePage(
                            //               title:
                            //                   result["fname"] + "'s Tasks",
                            //               uid: currentUser.uid,
                            //             ))))
                            .catchError((err) => print(err)))
                        .catchError((err) => _showMyLogFDialog(context));
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
