
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:dentaku/pages/calclulator/calculator.dart';

import '../../app.dart';

class Home extends StatelessWidget {

  const Home._({Key key}) : super(key: key);

  static const routeName = '/';

  static Widget newInstance() {
    return ChangeNotifierProvider(
      child: const Home._(),
      create: (context) => _Model(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialValue = Provider.of<AppModel>(context).getInitialValue();
    final navigatorKey = GetIt.instance.get<GlobalKey<NavigatorState>>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: const Text('go to calculator'),
              onPressed: () => navigatorKey.currentState.pushNamed(CalculatorPage.routeName),
            ),
            Builder(
              builder: (context) {
                return initialValue == null
                    ? Container()
                    : Text('last result is ' + initialValue.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}

class _Model extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
    print('dispose home model');
  }
}
