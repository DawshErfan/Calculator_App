import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const calcApp()); // Developed by : Erfan Naeini
}

class calcApp extends StatefulWidget {
  const calcApp({super.key});

  @override
  State<calcApp> createState() => _calcAppState();
}

class _calcAppState extends State<calcApp> {
  var userInput = "";
  var finalResult = "";
  bool parantez = true; // true = (        false = )

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'ori'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              flex: 25,
              child: Container(
                color: HexColor('#031D30'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 30,
                      maxLines: 1,
                      "$userInput",
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                    ),
                    AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 30,
                      maxLines: 1,
                      "$finalResult",
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 75,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black, border: Border.all(width: 0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getRows("ac", "ce", "/", "%"),
                    getRows("7", "8", "9", "*"),
                    getRows("4", "5", "6", "+"),
                    getRows("1", "2", "3", "-"),
                    getRows("()", "0", ".", "="),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  ////////////                     Widgets            *************************************
  Widget getRows(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getBackColor(text1),
            minimumSize: Size(95, 95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (text1 == "()") {
              setState(() {
                if (parantez) {
                  userInput += "(";
                } else {
                  userInput += ")";
                }
                parantez = !parantez;
              });
            } else {
              if (text1 == "ac") {
                setState(() {
                  userInput = "";
                  finalResult = "";
                });
              } else {
                btnPress(text1);
              }
            }
          },
          child: Text(
            "$text1",
            style: TextStyle(
                color: getColors(text1),
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getBackColor(text2),
            minimumSize: Size(95, 95),
            side: BorderSide(width: 0, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (text2 == "ce") {
              if (userInput.length > 0) {
                setState(() {
                  userInput = userInput.substring(0, userInput.length - 1);
                });
              }
            } else {
              btnPress(text2);
            }
          },
          child: Text(
            "$text2",
            style: TextStyle(
                color: getColors(text2),
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getBackColor(text3),
            minimumSize: Size(95, 95),
            side: BorderSide(width: 0, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            btnPress(text3);
          },
          child: Text(
            "$text3",
            style: TextStyle(
              color: getColors(text3),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getBackColor(text4),
            minimumSize: Size(95, 95),
            side: BorderSide(width: 0, style: BorderStyle.solid),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (text4 == "=") {
              if (userInput == "") {
                userInput = "";
              } else {
                Parser parser = Parser();
                Expression expression = parser.parse(userInput);
                ContextModel contextModel = ContextModel();
                double result =
                    expression.evaluate(EvaluationType.REAL, contextModel);
                setState(() {
                  finalResult = result.toString();
                });
              }
            } else {
              btnPress(text4);
            }
          },
          child: Text(
            "$text4",
            style: TextStyle(
                color: getColors(text4),
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  bool checkOperators(String text) {
    var list = ["ce", "+", "-", "*", "/", "%", "()"];
    for (var item in list) {
      if (text == item) {
        return true;
      }
    }
    return false;
  }

  Color getColors(String text) {
    if (checkOperators(text)) {
      return HexColor('#0F92F0');
    } else if (text == "=") {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  Color getBackColor(String text) {
    if (checkOperators(text)) {
      return HexColor('#031D30');
    } else if (text == "ac") {
      return HexColor('#333333');
    } else if (text == "=") {
      return HexColor('#0F92F0');
    } else {
      return HexColor('#141414');
    }
  }

  void btnPress(String text) {
    setState(() {
      userInput += text;
    });
  }
}
