
import 'package:dentaku/widgets/horizontal_split_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:dentaku/pages/calclulator/calculator.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

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
      appBar: AppBar(
        centerTitle: true,
        title: const ImageIcon(
          AssetImage('assets/logo.png'),
          color: Colors.white,
          size: 150,
        ),
      ),
      body: HorizontalSplitWidget.newInstance(
        maxHeight: 300,
        minHeight: 50,
        child: Container(
          color: Colors.amberAccent,
          child: Center(
            child: Text('計算機領域'),
          ),
        ),
      )

      //bottomSheet: SolidBottomSheet(
      //  showOnAppear: true,
      //  maxHeight: 400,
      //  headerBar: Container(
      //    color: Colors.blue,
      //    child: Center(
      //      child: Text('swipe!'),
      //    ),
      //    height: 30,
      //  ),
      //  body: Container(
      //    color: Colors.amberAccent,
      //    child: Center(
      //      child: Text('計算機領域'),
      //    ),
      //  ),
      //)
    );
  }
}

class _Model extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }
}
