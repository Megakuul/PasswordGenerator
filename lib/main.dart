import 'body.dart';
import 'background.dart';

import 'package:flutter/material.dart';


void main() {
  runApp(const passwordGen());
}

//Header
class passwordGen extends StatelessWidget {
  const passwordGen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Password Generator",
      home: mainPageState(),
    );
  }
}


//Create State for mainPage Widget
class mainPageState extends StatefulWidget {
  const mainPageState({Key? key}) : super(key: key);

  @override
  State<mainPageState> createState() => mainPage();
}

//Main Page
class mainPage extends State<mainPageState> {
  @override
  Widget build(BuildContext context) {
    return AnimatedGradient(
        Body()
    );
  }
}



