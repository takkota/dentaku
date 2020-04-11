import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

typedef OnPressed = void Function(BuildContext, Input);

class Button extends StatelessWidget {
  const Button._internal(
      {
        Key key,
        this.input,
        this.onPressed,
      }) : super(key: key);

  const Button.one(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '1'));
  const Button.two(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '2'));
  const Button.three(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '3'));
  const Button.four(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '4'));
  const Button.five(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '5'));
  const Button.six(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '6'));
  const Button.seven(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '7'));
  const Button.eight(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '8'));
  const Button.nine(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '9'));
  const Button.zero(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '0'));
  const Button.dot(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Number(name: '.', forbidDouble: true));
  const Button.ac(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Clear(name: 'ac'));
  const Button.back(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Clear(name: 'back'));
  const Button.plus(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Operator(name: '+', mathExp: '+'));
  const Button.minus(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Operator(name: '-', mathExp: '-'));
  const Button.divide(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Operator(name: '÷', mathExp: '/'));
  const Button.multiply(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Operator(name: '×', mathExp: '*'));
  const Button.mod(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Operator(name: '%', mathExp: '%'));
  const Button.equal(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Equal(name: '='));
  const Button.save(OnPressed onPressed): this._internal(onPressed: onPressed,
      input: const Save(name: '保存'));

  final OnPressed onPressed;
  final Input input;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        padding: const EdgeInsets.all(10),
        child: AutoSizeText(
          input.name,
          style: const TextStyle(
              fontSize: 50
          ),
        ),
        shape: CircleBorder(
            side: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid
            )
        ),
        onPressed: () => onPressed(context, input),
      ),
    );
  }
}

class Input {
  const Input({
    this.name,
    this.forbidDouble = false,
  });

  final String name;
  final bool forbidDouble;
}

class Number extends Input{
  const Number({
    String name,
    bool forbidDouble = false
  }): super(name: name, forbidDouble: forbidDouble);
}


class Operator extends Input{
  const Operator({
    String name,
    this.mathExp
  }): super(name: name, forbidDouble: true);

  final String mathExp;
}

class Equal extends Input{
  const Equal({
    String name,
  }): super(name: name);
}

class Clear extends Input{
  const Clear({
    String name,
  }): super(name: name);
}

class Save extends Input{
  const Save({
    String name,
  }): super(name: name);
}
