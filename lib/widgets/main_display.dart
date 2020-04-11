import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MainDisplay extends StatelessWidget {
  const MainDisplay(
      this.displayValue,
      this.interimResult,
      {
        Key key,
      }) : super(key: key);

  final String displayValue;
  final String interimResult;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 6;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
      height: height,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
          color: Colors.blueGrey,
          padding: const EdgeInsets.fromLTRB(6, 3, 6, 3),
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              AutoSizeText(
                '途中結果：${interimResult.toString()}',
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 20
                ),
              ),
              AutoSizeText(
                displayValue,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50
                ),
                textAlign: TextAlign.right,
              ),
            ],
          )
      ),
    );
  }
}
