import 'dart:async';

import 'package:floppy/bird/bird.dart';
import 'package:floppy/cscreen.dart';
import 'package:flutter/material.dart';

import 'barriers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double y = 0;
  double inPos = y;
  double h = 0;
  double t = 0;
  double g = -4.9;
  double v = 3.5;
  double bWidth = 0.1;
  double bHeight = 0.1;

  bool gameStarted = false;

  static List<double> barX = [2, 2 + 1.5];
  static double barWidth = 0.5;
  List<List<double>> barHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void start() {
    gameStarted = true;
    // ignore: prefer_const_constructors
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      h = g * t * t + v * t;
      setState(() {
        y = inPos - h;
      });
      if (dead()) {
        timer.cancel();
        gameStarted = false;
        _showDialog();
      }
      moveMap();
      t += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barX.length; i++) {
      setState(() {
        barX[i] -= 0.005;
      });
      if (barX[i] < -1.5) {
        barX[i] += 3;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      y = 0;
      gameStarted = false;
      t = 0;
      inPos = y;
      barX = [2, 2 + 1.5];
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.redAccent,
            title: const Center(
              child: Text(
                "GAME OVER",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: Colors.white,
                    child: const Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      t = 0;
      inPos = y;
    });
  }

  bool dead() {
    if (y < -1 || y > 1) {
      return true;
    }
    for (int i = 0; i < barX.length; i++) {
      if (barX[i] <= bWidth &&
          barX[i] + barWidth >= -bWidth &&
          (y <= -1 + barHeight[i][0] || y + bHeight >= 1 - barHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameStarted ? jump : start,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.greenAccent,
                child: Center(
                  child: Stack(
                    children: [
                      Bird(
                        y: y,
                        bWidth: bWidth,
                        bHeight: bHeight,
                      ),
                      CScreen(gameHasStarted: gameStarted),
                      Barriers(
                        barrierX: barX[0],
                        barrierWidth: barWidth,
                        barrierHeight: barHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      Barriers(
                        barrierX: barX[0],
                        barrierWidth: barWidth,
                        barrierHeight: barHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      Barriers(
                        barrierX: barX[1],
                        barrierWidth: barWidth,
                        barrierHeight: barHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      Barriers(
                        barrierX: barX[1],
                        barrierWidth: barWidth,
                        barrierHeight: barHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'S C O R E',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '10',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'B E S T',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
