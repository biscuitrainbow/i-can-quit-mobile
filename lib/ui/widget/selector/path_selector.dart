import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';

class PathSelector extends StatelessWidget {
  final bool selected;
  final String title;
  final String description;
  final Function onSelected;

  const PathSelector({
    Key key,
    this.selected = false,
    this.title,
    this.description,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? ColorPalette.primary : Colors.grey.shade400,
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: selected ? Styles.headerSectionPrimary : Styles.headerSection,
            ),
            Text(
              description,
              style: Styles.descriptionSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
