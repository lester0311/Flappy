import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const Floppy());
}

class Floppy extends StatelessWidget {
  const Floppy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
