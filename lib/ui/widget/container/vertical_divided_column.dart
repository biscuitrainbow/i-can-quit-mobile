import 'package:flutter/material.dart';

class VerticalDividedColumn extends StatelessWidget {
  final Widget top;
  final Widget bottom;

  VerticalDividedColumn({
    Key key,
    @required this.top,
    @required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: SingleChildScrollView(child: top)),
        bottom,
      ],
    );
  }
}
