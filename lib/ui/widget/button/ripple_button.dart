import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final Key key;
  final Function onPress;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color highlightColor;
  final BoxDecoration decoration;

  RippleButton({
    this.key,
    this.onPress,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.highlightColor,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: this.decoration,
      color: this.backgroundColor,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: InkWell(
          highlightColor: highlightColor,
          splashColor: highlightColor,
          onTap: onPress,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
