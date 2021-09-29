import 'package:flutter/material.dart';

class Barriers extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final barrierWidth; // out of 2, where 2 is the width of the screen
  // ignore: prefer_typing_uninitialized_variables
  final barrierHeight; // proportion of the screenheight
  // ignore: prefer_typing_uninitialized_variables
  final barrierX;
  final bool isThisBottomBarrier;

  Barriers(
      {this.barrierHeight,
      this.barrierWidth,
      required this.isThisBottomBarrier,
      this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
