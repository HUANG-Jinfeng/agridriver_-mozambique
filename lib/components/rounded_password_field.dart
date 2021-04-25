import 'package:flutter/material.dart';
import 'package:testing_app/components/text_field_container.dart';
import 'package:testing_app/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController cont;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.cont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        controller: cont,
        validator: (value) {
          if (value == null || value.isEmpty) {
            if (value.length < 6) {
              return "Password must be 6 or more";
            }
            return "Field cannot be empty";
          }
          return null;
        },
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          //   color: kPrimaryColor,
          // ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
