import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';

class ExpandedButton extends StatelessWidget {
  final Function onPressed;
  final String title;

  ExpandedButton({
    Key key,
    this.onPressed,
    this.title = 'ตกลง',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: FlatButton(
        onPressed: onPressed,
        color: ColorPalette.primary,
        child: Text(
          title,
          style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
