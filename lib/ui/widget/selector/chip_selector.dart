import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';

class ChipSelector extends StatelessWidget {
  final bool selected;
  final String label;
  final Color activeColor;
  final Function onPressed;

  ChipSelector({
    Key key,
    this.selected = false,
    @required this.label,
    this.activeColor = Colors.green,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Chip(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        backgroundColor: selected ? ColorPalette.primary : ColorPalette.primaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : ColorPalette.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
