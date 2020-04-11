import 'package:dentaku/widgets/main_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class Calculator extends StatelessWidget {
  const Calculator(
      {
        Key key,
        this.displayValue,
        this.interimResult,
        this.onNumber,
        this.onOperator,
        this.onClear,
        this.onEqual,
        this.onSave,
      }) : super(key: key);

  final String displayValue;
  final String interimResult;
  final OnPressed onNumber;
  final OnPressed onOperator;
  final OnPressed onClear;
  final OnPressed onEqual;
  final OnPressed onSave;

  @override
  Widget build(BuildContext context) {
    final one = Button.one(onNumber);
    final two = Button.two(onNumber);
    final three = Button.three(onNumber);
    final four = Button.four(onNumber);
    final five = Button.five(onNumber);
    final six = Button.six(onNumber);
    final seven = Button.seven(onNumber);
    final eight = Button.eight(onNumber);
    final nine = Button.nine(onNumber);
    final zero = Button.zero(onNumber);
    final dot = Button.dot(onNumber);
    final ac = Button.ac(onClear);
    final back = Button.back(onClear);
    final plus = Button.plus(onOperator);
    final minus = Button.minus(onOperator);
    final divide = Button.divide(onOperator);
    final multiply = Button.multiply(onOperator);
    final mod = Button.mod(onOperator);
    final equal = Button.equal(onEqual);
    final save = Button.save(onSave);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MainDisplay(displayValue, interimResult),
        buildRow([ac, back, mod, divide]),
        buildRow([seven, eight, nine, multiply]),
        buildRow([four, five, six, minus]),
        buildRow([one, two, three, plus]),
        buildRow([save, zero, dot, equal])
      ]
    );
  }

  Widget buildRow(List<Button> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buttons
      ),
    );
  }
}
