import 'package:flutter/material.dart';
import 'package:testing_app/components/text_field_container.dart';
import 'package:testing_app/constants.dart';

class RoundedEmailField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController cont;
  const RoundedEmailField({
    Key key,
    this.hintText,
    this.icon = Icons.email,
    this.onChanged,
    this.cont,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: onChanged,
        controller: cont,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
