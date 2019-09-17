import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';

class HealthRegenerationBadge extends StatefulWidget {
  final String title;
  final String regeneratedMessage;
  final Duration duration;
  final DateTime latestHasSmokedDateTime;

  HealthRegenerationBadge({
    @required this.title,
    @required this.duration,
    this.regeneratedMessage = 'ปกติ',
    @required this.latestHasSmokedDateTime,
  });

  @override
  _HealthRegenerationBadgeState createState() => _HealthRegenerationBadgeState();
}

class _HealthRegenerationBadgeState extends State<HealthRegenerationBadge> {
  Timer _timer;
  DateTime _now;

  bool get hasPassTheDuration => _now.difference(widget.latestHasSmokedDateTime).compareTo(widget.duration) > 0;

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
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          width: 60,
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: hasPassTheDuration ? ColorPalette.primary : Colors.grey.shade400,
              width: 2.0,
            ),
          ),
          child: Icon(
            FontAwesomeIcons.running,
            color: hasPassTheDuration ? ColorPalette.primary : Colors.grey.shade400,
          ),
        ),
        SizedBox(height: 4),
        Text(widget.title),
        Text(
          hasPassTheDuration ? widget.regeneratedMessage : 'ผิดปกติ',
          style: Styles.descriptionSecondary,
        ),
      ],
    );
  }
}
