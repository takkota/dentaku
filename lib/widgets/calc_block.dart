import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentaku/pages/models/calculator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalcBlock extends StatelessWidget {

  const CalcBlock(this.stack, { Key key }) : super(key: key);

  final MathStack stack;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.end,
            spacing: 8.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: buildBoxes(stack),
          ),
        ));
  }


  List<Widget> buildBoxes(MathStack stack) {
    return stack.getElements().map((el) {
      if (el.isNumber()) {
        return _numberBox(el.getDisplay());
      } else {
        return _operatorBox(el.getDisplay());
      }
    }).toList();
  }
}


Widget _numberBox(String value) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey,
      ),
      color: Colors.white30,
    ),
    child: AutoSizeText(
      '$value',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'MonteSerrat', fontSize: 30),
    ),
  );
}

Widget _operatorBox(String operator) {
  return Container(
    child: AutoSizeText(
      '$operator',
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
      ),
    ),
  );
}
