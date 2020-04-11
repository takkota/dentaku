
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:dentaku/pages/home/home.dart';

import 'consts.dart';
import 'resources/api/rest_client.dart';
import 'resources/shared_preferences/shared_preferences_wrapper.dart';
import 'router.dart';
import 'widgets/theme.dart';

class App extends StatelessWidget {

  const App._({Key key}) : super(key: key);

  static Widget newInstance() {
    return ChangeNotifierProvider(
      child: const App._(),
      create: (context) => AppModel(),
    );
  }


  @override
  Widget build(BuildContext context) {
    final navigatorKey = GetIt.instance.get<GlobalKey<NavigatorState>>();

    return MaterialApp(
      title: appName,
      theme: ThemeData.dark(),
      onGenerateRoute: (settings) => Provider.of<Router>(context, listen: false)
          .onGenerateRoute(settings),
      navigatorKey: navigatorKey,
      home: Home.newInstance(),
    );
  }
}

class AppModel with ChangeNotifier {
  AppModel() {
    _lastResult = sharedPreferences.getLastSavedResult();
  }

  SharedPreferencesWrapper sharedPreferences = GetIt.instance
      .get<SharedPreferencesWrapper>();

  RestClient restClient = GetIt.instance.get<RestClient>();

  int _lastResult;

  int get lastResult {
    return _lastResult;
  }

  //void fetchApi() {
  //  //restClient.getTasks().then((it) => {
  //  //});
  //}

  void incrementLastResult(int result) {
    if (_lastResult == null) {
      _lastResult = result;
    } else {
      _lastResult += result;
    }
    notifyListeners();
  }

  void saveLastResult() {
    sharedPreferences.saveLastResult(_lastResult);
  }

  int getInitialValue() {
    return _lastResult ?? sharedPreferences.getLastSavedResult();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
