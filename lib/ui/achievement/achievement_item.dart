import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/achievement.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AchievementItem extends StatefulWidget {
  final Achievement achievement;

  AchievementItem({Key key, this.achievement}) : super(key: key);

  @override
  _AchievementItemState createState() => _AchievementItemState();
}

class _AchievementItemState extends State<AchievementItem> {
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
              initialValue: 0,
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  progressBarColor: ColorPalette.primary,
                  trackColor: Colors.grey.shade300,
                  hideShadow: true,
                ),
                size: 70,
                angleRange: 360,
              ),
              innerWidget: (value) => Icon(
                FontAwesomeIcons.trophy,
                color: widget.achievement.achieved ? ColorPalette.primary : Colors.grey,
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.achievement.name,
                style: Styles.title.copyWith(fontSize: 18),
              ),
              Text(
                widget.achievement.description,
                style: Styles.descriptionSecondary,
              ),
            ],
          ),
        )
      ],
    );
  }
}
