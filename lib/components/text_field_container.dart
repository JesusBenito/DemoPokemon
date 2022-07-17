import 'package:flutter/material.dart';

import '../constants.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: (Theme.of(context) == Brightness.dark) ? kPrimaryLightColor : Colors.white70,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
