import 'package:dentaku/utils/math_util.dart';
import 'package:dentaku/widgets/button.dart';
import 'package:flutter/material.dart';

class CalculatorModel extends ChangeNotifier {

  MathElement currentInput = MathElement();
  // 先頭(0)が一番最新
  final List<MathStack> _stacks = [MathStack()];
  int _currentStackPosition = 0;

  void inputNumber(Number number) {
    _newStackIfNeed();
    if (currentInput.isOperator()) {
      // Operator入力中であれば、入力中のものをstack追加
      addElement();
    }
    currentInput.addNumber(number);
    notifyListeners();
  }

  void inputOperator(Operator operator) {
    _newStackIfNeed();
    if (currentInput.isNumber()) {
      // Number入力中であれば、入力中のものをstack追加
      addElement();
    }
    currentInput.addOperator(operator);
    notifyListeners();
  }

  void inputEqual(Equal input) {
    final currentStack = _stacks[_currentStackPosition];
    if (currentStack.getElements().length < 2) {
      // 入力中の数値含めて要素が最低3つないと計算が成り立たないので反応しない
      return;
    }
    if (currentInput.isNumber()) {
      // 数値入力中であれば追加する。
      currentStack.addElement(currentInput);
    }
    finalizeStack();
    notifyListeners();
  }

  void addElement() {
    _stacks[_currentStackPosition].addElement(currentInput);
    // 追加したら新しいElementを用意する
    currentInput = MathElement();
  }

  String getInputDisplay() {
    // 現在の入力値を取得
    return currentInput.getDisplay();
  }

  String getResultDisplay() {
    // 計算結果を取得
    final currentStack = _stacks[_currentStackPosition];
    return currentStack.sumUpStack().toString();
  }


  bool isFinalized() {
    // 計算が確定されているか
    return _stacks[_currentStackPosition].isFinalized;
  }

  MathStack getStackAt(int i) {
    return _stacks[i];
  }

  int getStackCount() {
    return _stacks.length;
  }

  //void inputClear(Clear buttonType) {
  //  if (buttonType == Clear.ac) {
  //    // timelineを一掃
  //  } else if (buttonType == Clear.back) {
  //    // TODO: 現在の入力値をモデル化
  //    currentInput = currentInput.substring(0, currentInput.length - 1);
  //    if (currentInput.isEmpty) {
  //      if (previousPhase == Phase.number) {
  //        final lastInput = timeline.popLastInput() as Operator;
  //        currentInput = lastInput.name;
  //        previousPhase = Phase.operator;
  //      } else {
  //        final lastInput = timeline.popLastInput() as String;
  //        currentInput = lastInput;
  //        previousPhase = Phase.number;
  //      }
  //    }
  //  }
  //}

  void _newStackIfNeed() {
    if (_stacks.isEmpty || _stacks.first.isFinalized) {
      // stack新たに追加
      if (_stacks.first.isFinalized) {
        // 計算結果を引き継ぎ
        currentInput = _stacks.first.getResultAsElement();
      }
      _stacks.insert(0, MathStack());
      _currentStackPosition = 0;
    }
  }

  //dynamic popLastInput() {
  //  return stacks[currentStackPosition].popStack();
  //}

  void finalizeStack() {
    _stacks[_currentStackPosition].isFinalized = true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MathStack {
  final List<MathElement> _stack = [];
  bool isFinalized = false;

  void addElement(MathElement el) {
    _stack.add(el);
  }

  List<MathElement> getElements() {
    return _stack;
  }

  bool _isLastInputOperator() {
    return _stack.last.isOperator();
  }
  bool _isLastInputNumber() {
    return _stack.last.isNumber();
  }

  //dynamic popStack() {
  //  if (_isLastInputNumber()) {
  //    if (_numberStack.isEmpty) {
  //      return null;
  //    }
  //    final lastStack = _numberStack.last;
  //    _numberStack.removeLast();
  //    return lastStack;
  //  } else if (_isLastInputOperator()) {
  //    if (_operatorStack.isEmpty) {
  //      return null;
  //    }
  //    final lastStack = _operatorStack.last;
  //    _operatorStack.removeLast();
  //    return lastStack;
  //  }
  //}

  //List<String> getValueStack() {
  //  return _numberStack;
  //}
  //List<Operator> getOperatorStack() {
  //  return _operatorStack;
  //}

  double sumUpStack() {
    final mathExp = _buildMathExp();
    return MathUtil.evaluateAsReal(mathExp);
  }

  String _buildMathExp() {
    if (_stack.isEmpty) {
      return '0';
    }

    var exp = '';
    _stack.asMap().forEach((i, el) {
      if (el.isNumber() || (el.isOperator() && i < _stack.length - 1)) {
        // 最後のOperatorは計算に入れない
        exp = exp + el.getMathExp();
      }
    });
    return exp;
  }

  MathElement getResultAsElement() {
    final numbers = sumUpStack().toString().runes.map((rune) {
      return Number(name: String.fromCharCode(rune));
    }).toList();

    return MathElement()..addNumbers(numbers);
  }

  List<MathElement> getMathExpAsElements() {
    return List();
  }
}

class MathElement {
  List<Input> inputs = [];

  void addNumbers(List<Number> numbers) {
    numbers.forEach(addNumber);
  }

  void addNumber(Number number) {
    if (isOperator()) {
      // TODO: throw error
    }

    if (number.forbidDouble
        && inputs.contains(number)) {
      // dotは２つ入れられない
      return;
    }
    if (inputs.length == 1
        && inputs.first.name == '0') {
      if (number.name != '.') {
        // 0表示中は上書き
        inputs.first = number;
      }
    }
    inputs.add(number);
  }

  void addOperator(Operator operator) {
    if (isNumber()) {
      print('error');
      // TODO: throw error
    }
    if (inputs.length == 1 && inputs.first is Operator) {
      inputs.first = operator;
    } else if (inputs.isEmpty) {
      inputs.add(operator);
    } else {
      // TODO: throw error
    }
  }

  // 自身がOperatorであるか
  bool isOperator() {
    return inputs.any((input) {
      return input is Operator;
    });
  }

  // 自身がNumberであるか
  bool isNumber() {
    return inputs.any((input) {
      return input is Number;
    });
  }

  String getDisplay() {
    if (inputs.isEmpty) {
      return '0';
    }
    return inputs.map((input) {
      return input.name;
    }).join('');
  }

  String getMathExp() {
    if (inputs.isEmpty) {
      return '';
    }

    if (isOperator()) {
      return (inputs.first as Operator).mathExp;
    } else {
      return inputs.map((input) {
        return input.name;
      }).join('');
    }
  }
}
