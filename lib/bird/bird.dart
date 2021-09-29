import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final y;
  final double bWidth;
  final double bHeight;
  // ignore: use_key_in_widget_constructors
  const Bird({this.y, required this.bWidth, required this.bHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, y),
      child: Image.asset(
        'lib/bird/bird.png',
        width: 50,
      ),
    );
  }
}
