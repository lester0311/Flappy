import 'package:flutter/material.dart';

class CScreen extends StatelessWidget {
  final bool gameHasStarted;

  CScreen({required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      alignment: Alignment(0, -0.5),
      child: Text(
        gameHasStarted ? '' : 'Tap  To  Start',
        // ignore: prefer_const_constructors
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
