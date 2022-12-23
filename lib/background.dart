import 'dart:ui';
import 'package:flutter/material.dart';



//AnimatedGradient Widget (Background)
class AnimatedGradient extends StatefulWidget {
  Widget Child;

  AnimatedGradient(this.Child);

  @override
  _AnimatedGradient createState() => _AnimatedGradient(Child);
}

class _AnimatedGradient extends State<AnimatedGradient> {

  final Key key = Key("Test");

  Widget Child;

  _AnimatedGradient(this.Child);

  List<Color> colrList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink
  ];

  List<Color> swapColors(List<Color> list) {
    Color tmpColr = list[0];
    list.removeAt(0);
    list.insert(list.length, tmpColr);

    return list;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Invokes Animation
      setState((){
        colrList = swapColors(colrList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState((){
          colrList = swapColors(colrList);
        });
      },
      child: AnimatedContainer(
        key: key,

        duration: Duration(seconds: 4),
        onEnd: () {
          setState((){
            colrList = swapColors(colrList);
          });
        },
        curve: Curves.ease,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.black,
                  colrList[0]
                ]
            )
        ),
        child: Child,
      )
    );
  }

}