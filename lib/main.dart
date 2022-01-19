import 'dart:developer';
import 'dart:async';
import 'button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

String exp = '0';
String ans = "0";
int parctr = 0;

Map<String, String> buttons = {
  "AC": "AC",
  "par": "op",
  "per": "op",
  "div": "op",
  "7": "n",
  "8": "n",
  "9": "n",
  "mul": "op",
  "4": "n",
  "5": "n",
  "6": "n",
  "min": "op",
  "1": "n",
  "2": "n",
  "3": "n",
  "plu": "op",
  "0": "n",
  ".": "n",
  "del": "del",
  "equ": "re"
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  //===================== FUNCTIONS ==================================

  clearScreen(String a) {
    exp = '0';
    ans = '0';
    setState(() {});
  }

  backspace(String a) {
    exp = exp.substring(0, exp.length - 1);
    setState(() {});
  }

  addNumber(String string) {
    exp = exp + string;
    setState(() {});
  }

  addOperator(String string) {
    String op = "";
    switch (string) {
      case "min":
        op = "-";
        break;
      case "plu":
        op = "+";
        break;
      case "mul":
        op = "*";
        break;
      case "div":
        op = "/";
        break;
      case "per":
        op = "%";
        break;
      case "par":
        {
          if (parctr == 0) {
            exp = exp + "(";
            parctr = 1;
          } else {
            exp = exp + ")";
            parctr = 0;
          }
        }
    }
    exp = exp + op;
    setState(() {});
  }

  showResult(String a) {
    String temp = exp.replaceAll(RegExp(r"(?<=\d)\(|(?<=\))\("), "*(");
    Parser p = Parser();
    ContextModel cm = ContextModel();
    try {
      Expression expE = p.parse(temp);
      double eval = expE.evaluate(EvaluationType.REAL, cm);
      ans = (eval % 1 == 0) ? eval.toInt().toString() : eval.toString();
      setState(() {});
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final GlobalKey _key = GlobalKey();

  //===================== MAIN DESIGN ==================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Calculator',
          style: GoogleFonts.lato(color: Colors.black87),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: const Color.fromRGBO(0, 0, 0, 0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      exp,
                      style: const TextStyle(
                        fontSize: 24.0,
                        height: 1.2,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      ans.toString(),
                      style: const TextStyle(
                        fontSize: 48.0,
                        height: 1.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemBuilder: (context, index) {
                  var string = buttons.keys.elementAt(index);
                  var type = buttons[string];
                  void Function(String) ont;
                  switch (type) {
                    case "AC":
                      ont = clearScreen;
                      break;
                    case "op":
                      ont = addOperator;
                      break;
                    case "re":
                      ont = showResult;
                      break;
                    case "del":
                      ont = backspace;
                      break;
                    default:
                      ont = addNumber;
                  }
                  return ButtonMaker(
                    string: string,
                    type: type!,
                    ont: ont,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
