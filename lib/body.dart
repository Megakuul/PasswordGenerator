import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

const _Letters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
const _Numbers = '123456789';
const _Symbols = '(){}/=&!?*';

class Reference {
  var parameter;

  Reference(this.parameter);
}


//Body Widget
class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {

  final TextBoxController = TextEditingController();

  void createPassword(double numberOfSigns, bool Numbers, bool Symbols) {
    String tmpSigns = _Letters;
    String rndString = "";

    if (Numbers) {
      tmpSigns += _Numbers;
    }
    if (Symbols) {
      tmpSigns += _Symbols;
    }

    for (int i = 0; i < numberOfSigns; i++)
    {
      Random rnd = Random();

      rndString += tmpSigns[rnd.nextInt(tmpSigns.length)];
    }
    TextBoxController.text=rndString;
  }

  void copyPassword() {
    Clipboard.setData(ClipboardData(text:TextBoxController.text));
  }

  double _sliderVal = 8;
  bool textBxenabled = false;
  Reference useNumbers = Reference(true);
  Reference useSigns = Reference(true);

  OutlineInputBorder createInputBorder(Color color, double width, double radius) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(width: width, color: color)
    );
  }

  @override
  void dispose() {
    super.dispose();
    TextBoxController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Creates Password on build
      setState((){
        createPassword(8, useNumbers.parameter, useSigns.parameter);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 390) {

    }
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.cached_sharp),
          tooltip: "create and copy password",
          onPressed: () {
            setState((){
              createPassword(_sliderVal, useNumbers.parameter, useSigns.parameter);
              copyPassword();
            });
          },
        ),
        body: Align(
            alignment: Alignment.center,
            child: SizedBox(
                height: 200,
                width: 600,
                child: Column(
                  children: [

                    Container(
                      decoration: const BoxDecoration(
                      ),
                      child: TextField(
                        controller: TextBoxController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(fontSize: 25, fontWeight: FontWeight.w300),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: createInputBorder(Colors.black, 3, 10),
                            focusedBorder: createInputBorder(Colors.green, 4, 10)
                        ),
                        showCursor: true,
                        cursorWidth: 4,
                        cursorColor: Colors.green,
                      ),
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, right: 0),
                          child: Row(
                            children: [
                              Expanded(child: Align(alignment: Alignment.topCenter, child: CheckboxWithText("Numbers", useNumbers))),
                              Expanded(child: Align(alignment: Alignment.topCenter, child: CheckboxWithText("Symbols", useSigns))),
                              //Refresh Button
                              Expanded(child: Align(
                                alignment: Alignment.topCenter,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 20),
                                        backgroundColor: Colors.black,
                                        primary: Colors.white,
                                        fixedSize: const Size.fromWidth(120)
                                    ),
                                    onPressed: () => setState((){ createPassword(_sliderVal, useNumbers.parameter, useSigns.parameter); }),
                                    child: RichText(
                                        text: const TextSpan(
                                            children: [
                                              TextSpan(text: "Refresh ", style: TextStyle(fontSize: 17, color: Colors.white)),
                                              WidgetSpan(child: Icon(Icons.cached_rounded, size: 17))
                                            ]
                                        )
                                    )
                                ),
                              )),
                              //Copy Button
                              Expanded(child: Align(
                                  alignment: Alignment.topCenter,
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          textStyle: const TextStyle(fontSize: 20),
                                          backgroundColor: Colors.black,
                                          primary: Colors.white,
                                          fixedSize: const Size.fromWidth(120)
                                      ),
                                      onPressed: () {
                                        copyPassword();
                                      },
                                      child: RichText(
                                          text: const TextSpan(
                                              children: [
                                                TextSpan(text: "Copy ", style: TextStyle(fontSize: 17, color: Colors.white)),
                                                WidgetSpan(child: Icon(Icons.copy, size: 17))
                                              ]
                                          )
                                      )
                                  )
                              ))
                            ],
                          ),
                        )
                    ),
                    Slider(
                        max: 32,
                        min: 4,
                        divisions: 28,
                        thumbColor: Colors.black,
                        activeColor: Colors.black,
                        label: _sliderVal.toString(),
                        value: _sliderVal,
                        onChanged: (double value) {
                          setState(() {
                            _sliderVal = value;
                            createPassword(_sliderVal, useNumbers.parameter, useSigns.parameter);
                          });
                        }
                    ),
                  ],
                )
            )
        )
    );
  }
}

class CheckboxWithText extends StatefulWidget {

  final String Txt;
  Reference ref;

  CheckboxWithText(this.Txt, this.ref);



  @override
  _CheckboxWithText createState() => _CheckboxWithText(Txt, ref);
}

class _CheckboxWithText extends State<CheckboxWithText> {
  final String Txt;
  Reference ref;

  _CheckboxWithText(this.Txt, this.ref);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: ref.parameter,
            splashRadius: 0,
            activeColor: Colors.black,
            side: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            onChanged: (bool? value) {
              setState((){
                ref.parameter = !ref.parameter;
              });
            }
        ),
        Text(Txt)
      ],
    );
  }
}