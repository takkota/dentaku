
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HorizontalSplitWidget extends StatelessWidget {
  const HorizontalSplitWidget._({
    Key key,
    this.minHeight,
    this.maxHeight,
    this.child,
  }) : super(key: key);

  HorizontalSplitWidget.withProvider({
    Key key,
    this.minHeight,
    this.maxHeight,
    this.child,
  }) : super(key: key) {
  }

  static Widget newInstance({
    Key key,
    double minHeight,
    double maxHeight,
    Widget child,
  }) {
    return Provider<_Bloc>(
      child: HorizontalSplitWidget._(
          key: key,
          minHeight: minHeight,
          maxHeight: maxHeight,
          child: child
      ),
      create: (context) => _Bloc(),
      dispose: (_, bloc) => bloc.dispose(),
    );
  }

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<_Bloc>(context, listen: false);

    return Column(
      children: <Widget>[
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: Colors.orange,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text(index.toString());
              },
              reverse: true,
              itemCount: 100,
            ),
          ),
        ),
        StreamBuilder<double>(
          stream: bloc.height,
          // 表示状態にしたいので、初期値は最大
          initialData: maxHeight,
          builder: (context, snapShot) {
            return AnimatedContainer(
              height: snapShot.data,
              curve: Curves.easeOut,
              duration: Duration(milliseconds: bloc.smoothness.value),
              color: Colors.green,
              child: GestureDetector(
                onVerticalDragUpdate: (details) =>
                    _onVerticalDragUpdate(context, snapShot.data, details),
                onVerticalDragEnd: (details) => _onVerticalDragEnd(context),
                onTap: () => _onTap(context, snapShot.data),
                child: child,
              ),
            );
          },
        )

      ],
    );
  }

  void _onVerticalDragUpdate(BuildContext context,
      double currentHeight, DragUpdateDetails details) {
    _setDragSmoothness(context);

    if (((currentHeight - details.delta.dy) > minHeight) &&
        ((currentHeight - details.delta.dy) < maxHeight)) {
      Provider.of<_Bloc>(context, listen: false)
        ..isDragDirectionUp = details.delta.dy <= 0
        ..dispatch(currentHeight - details.delta.dy);
    }
  }

  void _onVerticalDragEnd(BuildContext context) {
    _setSwipeSmoothness(context);
    final bloc = Provider.of<_Bloc>(context, listen: false);

    if (bloc.isDragDirectionUp) {
      _show(context);
    } else {
      _hide(context);
    }
  }

  void _onTap(BuildContext context, double currentHeight) {
    final bloc = Provider.of<_Bloc>(context, listen: false);
    final isOpened = currentHeight == maxHeight;
    bloc.dispatch(isOpened ? minHeight : maxHeight);
  }

  void _setDragSmoothness(BuildContext context) {
    final bloc = Provider.of<_Bloc>(context, listen: false);
    bloc.smoothness = Smoothness.withValue(5);
  }

  void _setSwipeSmoothness(BuildContext context) {
    final bloc = Provider.of<_Bloc>(context, listen: false);
    bloc.smoothness = Smoothness.medium;
  }

  void _hide(BuildContext context) {
    // callback should be inserted here
    final bloc = Provider.of<_Bloc>(context, listen: false);
    bloc.dispatch(minHeight);
  }

  void _show(BuildContext context) {
    // callback should be inserted here
    final bloc = Provider.of<_Bloc>(context, listen: false);
    bloc.dispatch(maxHeight);
  }
}

class _Bloc {
  final StreamController<double> _heightController =
  StreamController<double>.broadcast();

  Stream<double> get height => _heightController.stream;
  Sink<double> get _heightSink => _heightController.sink;

  // 上にスワイプ中か
  bool isDragDirectionUp = false;

  Smoothness smoothness = Smoothness.medium;

  // Adds new values to streams
  void dispatch(double value) {
    _heightSink.add(value);
  }

  // Closes streams
  void dispose() {
    _heightController.close();
  }
}

class Smoothness {
  final int _value;

  Smoothness._() : _value = 0;

  // 名前付きコンストラクタ
  const Smoothness._low() : _value = 100;

  const Smoothness._medium() : _value = 250;

  const Smoothness._high() : _value = 500;

  const Smoothness._withValue(int value) : _value = value;

  static const Smoothness low = Smoothness._low();
  static const Smoothness medium = Smoothness._medium();
  static const Smoothness high = Smoothness._high();
  static Smoothness withValue(int value) => Smoothness._withValue(value);

  int get value => _value;
}

