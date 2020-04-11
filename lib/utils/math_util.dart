
import 'package:math_expressions/math_expressions.dart';

class MathUtil {

  static double evaluateAsReal(String mathExp) {
    final p = Parser();
    final exp = p.parse(mathExp);
    final eval = exp.evaluate(EvaluationType.REAL, ContextModel()) as double;

    return eval;
  }
}