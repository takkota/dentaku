
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:dentaku/app.dart';
import 'package:dentaku/router.dart';
import 'package:dentaku/run.iconfig.dart';

enum Environment {
  remote,
  local,
}

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> injectDependency() => $initGetIt(getIt);

Future run({@required Environment environment}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependency();

  switch (environment) {
    case Environment.remote:
      break;
    case Environment.local:
      break;
  }
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Router()),
      ],
      child: App.newInstance(),
    ),
  );
}
