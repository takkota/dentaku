
import 'package:flutter/material.dart';
import 'package:dentaku/pages/home/home.dart';

typedef WidgetPageBuilder = Widget Function(
    BuildContext context,
    RouteSettings settings,
    );


class Router {
  static const root = '/';

  final _basicRoutes = <String, WidgetPageBuilder>{
    Home.routeName: (context, settings) => Home.newInstance(),
  };

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    var pageBuilder = _basicRoutes[settings.name];
    if (pageBuilder != null) {
      return MaterialPageRoute<void>(
        builder: (context) => pageBuilder(context, settings),
        settings: settings,
      );
    }

    assert(false, 'unexpected routes: $settings');
    return null;
  }
}
