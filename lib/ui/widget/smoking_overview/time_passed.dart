import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:intl/intl.dart';

class TimePassed extends StatefulWidget {
  final DateTime from;

  const TimePassed({Key key, this.from}) : super(key: key);

  @override
  _TimePassedState createState() => _TimePassedState();
}

class _TimePassedState extends State<TimePassed> {
  final NumberFormat formatter = new NumberFormat("00");

  Timer _timer;
  DateTime _now;

  @override
  void initState() {
    super.initState();

    _now = DateTime.now();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text('${formatter.format(_now.difference(this.widget.from).inDays)}', style: TextStyle(fontSize: 32, color: Colors.grey.shade700)),
            Text('วัน', style: Styles.descriptionSecondary),
          ],
        ),
        SizedBox(width: 32),
        Column(
          children: <Widget>[
            Text('${formatter.format(_now.difference(this.widget.from).inHours % 24)}', style: TextStyle(fontSize: 32, color: Colors.grey.shade700)),
            Text('ชั่วโมง', style: Styles.descriptionSecondary),
          ],
        ),
        SizedBox(width: 32),
        Column(
          children: <Widget>[
            Text('${formatter.format(_now.difference(this.widget.from).inMinutes % 60)}',
                style: TextStyle(fontSize: 32, color: Colors.grey.shade700)),
            Text('นาที', style: Styles.descriptionSecondary),
          ],
        ),
        SizedBox(width: 32),
        Column(
          children: <Widget>[
            Text('${formatter.format(_now.difference(this.widget.from).inSeconds % 60)}',
                style: TextStyle(fontSize: 32, color: Colors.grey.shade700)),
            Text('วินาที', style: Styles.descriptionSecondary),
          ],
        ),
      ],
    );
  }
}
