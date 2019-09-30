import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RippleButton extends StatelessWidget {
  final Key key;
  final Function onPress;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color highlightColor;
  final BoxDecoration decoration;
  final Icon icon;
  RippleButton({
    this.key,
    this.onPress,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.highlightColor,
    this.decoration,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: this.decoration,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: InkWell(
          highlightColor: highlightColor,
          splashColor: highlightColor,
          onTap: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon ?? SizedBox(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
