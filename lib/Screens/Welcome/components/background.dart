import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 40,
            left: 15,
            child: Image.asset(
              "assets/images/LTID_logo_b.png",
              width: size.width * 0.5,
            ),
          ),
          // Positioned(
          //   bottom: -95,
          //   left: -15,
          //   child: Image.asset(
          //     "assets/images/welcome_bottom.png",
          //     width: size.width * 1.3,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}
