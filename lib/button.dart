import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'math_icons.dart';

Map<String, IconData> opIcon = {
  "div": MathIcons.div,
  "mul": MathIcons.mul,
  "min": MathIcons.min,
  "plu": MathIcons.plu,
  "equ": MathIcons.equ,
  "par": MathIcons.par,
  "per": MathIcons.per,
};

List<Color> whatColor(type) {
  switch (type) {
    case "AC":
      return [
        const Color.fromRGBO(69, 125, 71, 1),
        const Color.fromRGBO(141, 227, 144, 0.5),
        const Color.fromRGBO(118, 204, 121, 0.5),
      ];
    case "del":
      return [
        const Color.fromRGBO(196, 196, 196, 1),
        const Color.fromRGBO(96, 96, 96, 1),
        const Color.fromRGBO(66, 66, 66, 1),
      ];
    case "op":
      return [
        const Color.fromRGBO(89, 135, 133, 1),
        const Color.fromRGBO(170, 240, 237, 0.5),
        const Color.fromRGBO(144, 214, 211, 0.5),
      ];
    case "re":
      return [
        const Color.fromRGBO(115, 92, 48, 1),
        const Color.fromRGBO(237, 196, 119, 1),
        const Color.fromRGBO(204, 166, 94, 1),
      ];
    default:
      return [
        const Color.fromRGBO(96, 96, 96, 1),
        const Color.fromRGBO(227, 227, 227, 1),
        const Color.fromRGBO(196, 196, 196, 1),
      ];
  }
}

Widget whatContent(string, type) {
  switch (type) {
    case "re":
    case "op":
      {
        return Icon(
          opIcon[string],
          size: 16,
        );
      }
    default:
      return Text(
        string,
        style: GoogleFonts.lato(
          fontSize: 16.0,
        ),
      );
  }
}

class ButtonMaker extends StatefulWidget {
  ButtonMaker(
      {Key? key, required this.string, required this.type, required this.ont})
      : colorSet = whatColor(type),
        icon = whatContent(string, type);

  final String string;
  final String type;
  final List<Color> colorSet;
  final Widget icon;
  final Function(String) ont;

  @override
  State<ButtonMaker> createState() => _ButtonMakerState();
}

class _ButtonMakerState extends State<ButtonMaker> {
  var tapdown = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          widget.ont(widget.string);
        },
        style: ButtonStyle(
            enableFeedback: true,
            minimumSize: MaterialStateProperty.all(
              Size.infinite,
            ),
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            alignment: Alignment.center,
            backgroundColor: MaterialStateProperty.all(widget.colorSet[1]),
            foregroundColor: MaterialStateProperty.all(widget.colorSet[0]),
            overlayColor: MaterialStateProperty.all(widget.colorSet[2]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            )),
        child: widget.icon);
  }
}
