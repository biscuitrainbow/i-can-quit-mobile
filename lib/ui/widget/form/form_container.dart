import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';

class FormContainer extends StatelessWidget {
  final String title;
  final String label;
  final Widget child;
  final Function onPressed;

  FormContainer({
    Key key,
    this.title = '',
    this.label = '',
    this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.label.isNotEmpty
              ? Text(
                  label,
                  style: Styles.description,
                )
              : SizedBox(),
          SizedBox(height: 8.0),
          Container(
            height: 46.0,
            padding: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                title.isNotEmpty
                    ? Text(
                        title,
                        style: Styles.description,
                      )
                    : child,
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
