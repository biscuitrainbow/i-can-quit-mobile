import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/health_regeneration.dart';
import 'package:i_can_quit/ui/util/string_util.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class HealthRegenerationItem extends StatefulWidget {
  final String regeneratedMessage;
  final HealthRegeneration healthRegeneration;
  final DateTime latestHasSmokedDateTime;

  HealthRegenerationItem({
    this.regeneratedMessage = 'ปกติ',
    @required this.healthRegeneration,
    @required this.latestHasSmokedDateTime,
  });

  @override
  _HealthRegenerationItemState createState() => _HealthRegenerationItemState();
}

class _HealthRegenerationItemState extends State<HealthRegenerationItem> {
  Timer _timer;
  DateTime _now;

  bool get hasPassTheDuration => _now.difference(widget.latestHasSmokedDateTime).compareTo(widget.healthRegeneration.duration) > 0;

  Duration get afterLastSmokedDuration => _now.difference(widget.latestHasSmokedDateTime);

  DateTime get regeneratedDateTime => widget.latestHasSmokedDateTime.add(widget.healthRegeneration.duration);

  Duration get regenerationDuration => regeneratedDateTime.difference(widget.latestHasSmokedDateTime);

  Duration get regenerationDurationRemaining => regeneratedDateTime.difference(_now);

  double get regenerationProgressPercent => (afterLastSmokedDuration.inSeconds / regenerationDuration.inSeconds) * 100;

  @override
  void initState() {
    super.initState();

    _now = DateTime.now();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            SleekCircularSlider(
              min: 0,
              max: 100,
              initialValue: regenerationProgressPercent > 100 ? 100 : regenerationProgressPercent,
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  progressBarColor: ColorPalette.primary,
                  trackColor: Colors.grey.shade300,
                  hideShadow: true,
                ),
                size: 70,
                angleRange: 360,
              ),
              innerWidget: hasPassTheDuration ? (double value) => Icon(FontAwesomeIcons.running, color: ColorPalette.primary) : null,
            ),
            SizedBox(height: 4),
            if (regenerationDurationRemaining.isNegative)
              Text(
                'ฟื้นฟูแล้ว',
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
              )
            else
              Text(
                StringUtils.toRemainingText(regenerationDurationRemaining),
                style: TextStyle(fontSize: 14, color: Color(0XFF9E9E9E)),
              )
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.healthRegeneration.title,
                style: Styles.title.copyWith(fontSize: 18),
              ),
              Text(
                widget.healthRegeneration.description,
                style: Styles.descriptionSecondary,
              ),
            ],
          ),
        )
      ],
    );
  }
}
