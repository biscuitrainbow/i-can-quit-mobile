import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;

  CircleButton({Key key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.grey.shade400,
        size: 20.0,
      ),
      shape: CircleBorder(),
      elevation: 0.3,
      fillColor: Colors.white,
    );
  }
}
