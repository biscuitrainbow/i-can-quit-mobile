import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';

class OrganizationItem extends StatelessWidget {
  final String nameThai;
  final String nameEnglish;
  final String imageAsset;
  final double iconSize;

  OrganizationItem({Key key, @required this.nameThai, @required this.nameEnglish, @required this.imageAsset, this.iconSize = 70.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          imageAsset,
          width: iconSize,
        ),
        SizedBox(width: 14.0),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                nameThai,
                textAlign: TextAlign.left,
                style: Styles.title,
              ),
              Text(
                nameEnglish.toUpperCase(),
                textAlign: TextAlign.left,
                style: Styles.descriptionSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
