
import 'package:dentaku/pages/models/calculator_model.dart';
import 'package:dentaku/widgets/button.dart';
import 'package:dentaku/widgets/calculator.dart';
import 'package:dentaku/widgets/calc_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatelessWidget {

  const Home._({Key key}) : super(key: key);

  static const routeName = '/';

  static Widget newInstance() {
    return ChangeNotifierProvider(
      child: const Home._(),
      create: (context) => CalculatorModel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final initialValue = Provider.of<AppModel>(context).getInitialValue();
    //final navigatorKey = GetIt.instance.get<GlobalKey<NavigatorState>>();
    final calculatorMinHeight = MediaQuery.of(context).size.height / 6;
    final model = Provider.of<CalculatorModel>(context);

    return Scaffold(
      body: SlidingUpPanel(
          body: Container(
            margin: EdgeInsets.only(bottom: calculatorMinHeight),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (model.getStackAt(index).getElements().isNotEmpty) {
                  return CalcBlock(model.getStackAt(index));
                } else {
                  return Container();
                }
              },
              reverse: true,
              itemCount: model.getStackCount(),
            ),
          ),
          panel: Calculator(
            displayValue: model.isFinalized() ? model.getResultDisplay()
                : model.getInputDisplay(),
            interimResult: model.getResultDisplay(),
            onNumber: (BuildContext context, Input input) =>
                model.inputNumber(input as Number),
            onOperator: (BuildContext context, Input input) =>
              model.inputOperator(input as Operator),
            onEqual: (BuildContext context, Input input) =>
                model.inputEqual(input as Equal),
          ),
          parallaxEnabled: true,
          parallaxOffset: 1.0,
          minHeight: calculatorMinHeight,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
      ),
    );
  }
}

