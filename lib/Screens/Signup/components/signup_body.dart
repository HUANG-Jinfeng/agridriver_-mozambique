import 'package:flutter/material.dart';
import 'package:testing_app/Screens/Login/login_screen.dart';
import 'package:testing_app/Screens/Map/map_screen.dart';
import 'package:testing_app/Screens/Signup/components/signup_background.dart';
import 'package:testing_app/Screens/Signup/components/signup_or_divider.dart';
import 'package:testing_app/Screens/Signup/components/signup_social_icon.dart';
import 'package:testing_app/Screens/Welcome/welcome_screen.dart';
import 'package:testing_app/components/already_have_an_account_acheck.dart';
import 'package:testing_app/components/rounded_button.dart';
import 'package:testing_app/components/rounded_email_field.dart';
import 'package:testing_app/components/rounded_input_field.dart';
import 'package:testing_app/components/rounded_password_field.dart';
import 'package:testing_app/components/rounded_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_app/components/text_field_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../components/rounded_input_field.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class SignupBody extends StatelessWidget {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  User currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Size size = MediaQuery.of(context).size;
    return SignupBackground(
      child: SingleChildScrollView(
        child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGN UP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              RoundedInputField(
                hintText: "Full name",
                onChanged: (value) {},
                cont: fname,
              ),
              RoundedEmailField(
                hintText: "Email",
                onChanged: (value) {},
                cont: email,
              ),
              RoundedPhoneField(
                hintText: "Phone number",
                onChanged: (value) {},
                cont: phone,
              ),
              RoundedPasswordField(
                onChanged: (value) {},
                cont: password,
              ),
              Text(
                "Minimum 8 characters, at least 1 alphabet.",
                style: TextStyle(
                  color: kPrimaryNoteColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              RoundedButton(
                text: "SIGN UP",
                press: () {
                  if (_registerFormKey.currentState.validate()) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email.text, password: password.text)
                        .then((currentUser) => users
                            .add({
                              "uid": currentUser.user.uid,
                              "fname": fname.text,
                              "phone": phone.text,
                              "email": email.text,
                            })
                            .then((result) => {
                                  print("User Added"),
                                  fname.clear(),
                                  email.clear(),
                                  phone.clear(),
                                  password.clear(),
                                  _showRegSDialog(context),
                                })
                            .catchError((err) => print(err)))
                        .catchError((err) => print(err));
                  }
                },
              ),
              SizedBox(height: size.height * 0.02),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showRegSDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Registered Successfully'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Thank you for registering'),
              Text('Click Start to use AgriDriver'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Start'),
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
