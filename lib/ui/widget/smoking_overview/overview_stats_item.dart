import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';

class OverviewStatsItem extends StatelessWidget {
  const OverviewStatsItem({Key key, this.title, this.description, this.primary, this.unit, this.icon}) : super(key: key);

  final String title;
  final IconData icon;
  final String description;
  final String unit;
  final bool primary;

  OverviewStatsItem.primary({
    this.title,
    this.description,
    this.primary = true,
    this.unit,
    this.icon,
  });

  OverviewStatsItem.secondary({
    this.title,
    this.description,
    this.primary = false,
    this.unit,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return primary
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    description,
                    style: Styles.descriptionAccent,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(title, style: Styles.headerBigger),
                  SizedBox(width: 8),
                  Text(unit, style: Styles.descriptionAccent),
                ],
              ),
            ],
          )
        : Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(title, style: Styles.headerAccent),
                  SizedBox(width: 8),
                  Text(unit, style: Styles.descriptionAccent),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    description,
                    style: Styles.descriptionAccent,
                  ),
                ],
              ),
            ],
          );
  }
}
