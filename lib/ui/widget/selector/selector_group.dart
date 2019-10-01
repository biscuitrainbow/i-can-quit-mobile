import 'package:flutter/material.dart';

import 'chip_selector.dart';

class GroupSelector extends StatefulWidget {
  GroupSelector({
    @required this.items,
    @required this.onChanged,
    this.selectedItem = '',
    this.activeColor = Colors.green,
    this.title = '',
    this.warp = true,
  });

  final String title;
  final List<String> items;
  final Function(String) onChanged;
  final String selectedItem;
  final Color activeColor;
  final bool warp;

  @override
  GroupSelectorState createState() {
    return GroupSelectorState();
  }
}

class GroupSelectorState extends State<GroupSelector> {
  bool _isSelected(String item) {
    return item == widget.selectedItem;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.warp) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (widget.title.isNotEmpty)
            Row(
              children: <Widget>[
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                SizedBox(width: 16.0),
              ],
            ),
          Expanded(
            child: Wrap(
              spacing: 4.0,
              alignment: WrapAlignment.start,
              children: [
                for (final item in widget.items)
                  Container(
                    margin: EdgeInsets.only(right: 4.0),
                    child: ChipSelector(
                      onPressed: () => widget.onChanged(item),
                      activeColor: widget.activeColor,
                      selected: _isSelected(item),
                      label: item,
                    ),
                  ),
              ],
            ),
          )
        ],
      );
    }

    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (final item in widget.items)
            Container(
              margin: EdgeInsets.only(right: 4.0),
              child: ChipSelector(
                onPressed: () => widget.onChanged(item),
                activeColor: widget.activeColor,
                selected: _isSelected(item),
                label: item,
              ),
            ),
        ],
      ),
    );
  }
}
