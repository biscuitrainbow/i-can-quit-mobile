import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';

class NavigationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  NavigationTile({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.grey.shade600,
            size: 18,
          ),
          SizedBox(width: 8.0),
          Text(
            title,
            style: Styles.description,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
