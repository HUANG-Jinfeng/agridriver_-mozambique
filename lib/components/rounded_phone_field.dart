import 'package:flutter/material.dart';
import 'package:testing_app/components/text_field_container.dart';
import 'package:testing_app/constants.dart';

class RoundedPhoneField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController cont;
  const RoundedPhoneField({
    Key key,
    this.hintText,
    this.icon = Icons.phone,
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
