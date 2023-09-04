import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Kalkulator extends StatefulWidget {
  const Kalkulator({super.key});

  @override
  State<Kalkulator> createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  String userinput = "";
  String result = "0";

  List<String> buttonList = [
    '%',
    '^',
    'log',
    'sin',
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '3',
    '2',
    '1',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              child: resultWidget(),
              flex: 1,
            ),
            Flexible(
              child: buttonWidget(),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(25),
          alignment: Alignment.centerRight,
          child: Text(
            userinput,
            style: TextStyle(fontSize: 32),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(25),
          alignment: Alignment.centerRight,
          child: RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: StrutStyle(fontSize: 12),
            text: TextSpan(
                text: result,
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ),
      ],
    );
  }

  Widget buttonWidget() {
    return GridView.builder(
        itemCount: buttonList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return button(buttonList[index]);
        });
  }

  Widget button(String text) {
    return
        MaterialButton(
            onPressed: () {
              setState(() {
                handleButtonPPress(text);
              });
            },
            color: getColor(text),
            textColor: Colors.white,
            child: Text(
              text,
              style: TextStyle(fontSize: 25),
            ),
            shape: const CircleBorder());
  }

  handleButtonPPress(String text) {
    if (text == "AC") {
      userinput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      userinput = userinput.substring(0, userinput.length - 1);
      return;
    }
    if (text == "=") {
      result = calculate();
      if (result.endsWith(".0")) result = result.replaceAll(".0", "");
      return;
    }
    userinput = userinput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userinput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  getColor(String text) {
    if (text == "/" ||
        text == "+" ||
        text == "*" ||
        text == "-" ||
        text == "=") {
      return Colors.orangeAccent;
    }
    if (text == "AC" || text == "C") {
      return Colors.red;
    }
    if (text == "(" || text == ")") {
      return Colors.blueGrey;
    }
    return Colors.lightBlue;
  }
}
