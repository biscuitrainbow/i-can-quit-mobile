import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_rounded_date_picker/cupertino_rounded_date_picker.dart';
// import 'package:flutter_rounded_date_picker/era_mode.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/ui/widget/selector/selector_group.dart';
import 'package:intl/intl.dart';

class SmokingEntryForm extends StatefulWidget {
  final bool firstTimesEntry;
  final Function(SmokingEntry) onChange;

  const SmokingEntryForm({
    Key key,
    this.firstTimesEntry = false,
    this.onChange,
  }) : super(key: key);

  @override
  _SmokingEntryFormState createState() => _SmokingEntryFormState();
}

class _SmokingEntryFormState extends State<SmokingEntryForm> {
  SmokingEntry _entry;

  @override
  void initState() {
    super.initState();

    _entry = this.widget.firstTimesEntry ? SmokingEntry.firstTimes() : SmokingEntry.create();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EntryContainer.secondary(
          title: "รู้สึกอยากสูบมากแค่ไหน",
          trailing: GroupSelector(
            items: ['ไม่เลย', 'น้อย', 'ปานกลาง', 'มาก', 'ควบคุมไม่ได้'],
            selectedItem: _entry.smokingNeededLevel,
            onChanged: (String neededLevel) {
              setState(() => _entry = _entry.copyWith(smokingNeededLevel: neededLevel));
              widget.onChange(_entry);
            },
          ),
        ),
        if (!widget.firstTimesEntry)
          EntryContainer.secondary(
            title: 'คุณได้สูบบุหรี่ไปหรือไม่',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _entry.hasSmoked ? "สูบ" : "ไม่ได้สูบ",
                  style: Styles.descriptionSecondary,
                ),
                Switch(
                  value: _entry.hasSmoked,
                  onChanged: (bool smoked) {
                    setState(
                      () => _entry = _entry.copyWith(
                        hasSmoked: smoked,
                        numberOfCigarettes: 0,
                      ),
                    );

                    widget.onChange(_entry);
                  },
                )
              ],
            ),
          ),
        if (_entry.hasSmoked)
          EntryContainer.secondary(
            title: 'สูบไปเป็นจำนวน',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: GroupSelector(
                    items: [for (var i = 1; i <= 30; i = i + 1) i].map((number) => number.toString()).toList(),
                    selectedItem: _entry.numberOfCigarettes.toString(),
                    warp: false,
                    onChanged: (String number) => setState(() {
                      setState(() => _entry = _entry.copyWith(numberOfCigarettes: int.parse(number)));
                      widget.onChange(_entry);
                    }),
                  ),
                ),
              ],
            ),
          ),
        EntryContainer.secondary(
          title: widget.firstTimesEntry ? 'คุณสูบบุหรี่ล่าสุดเมื่อไหร่' : 'วันที่บันทึก',
          trailing: GestureDetector(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  DateFormat('dd MMM yyyy hh:mm', 'th').format(_entry.datetime),
                  style: Styles.descriptionSecondary,
                ),
              ],
            ),
            onTap: () => {
              // CupertinoRoundedDatePicker.show(
              //   context,
              //   era: EraMode.BUDDHIST_YEAR,
              //   fontFamily: "Kanit",
              //   borderRadius: 16,
              //   initialDatePickerMode: CupertinoDatePickerMode.dateAndTime,
              //   onDateTimeChanged: (datetime) {
              //     setState(() => _entry = _entry.copyWith(datetime: datetime));
              //     widget.onChange(_entry);
              //   },
              // )
            },
          ),
        ),
        EntryContainer.secondary(
          title: 'สถานที่',
          trailing: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () async {
              final locationResult = await LocationPicker.pickLocation(context, DotEnv().env['GOOGLE_MAP_API_KEY']);

              if (locationResult != null) {
                setState(() {
                  _entry = _entry.copyWith(location: locationResult.latLng);
                });

                widget.onChange(_entry);
              }
            },
          ),
        ),
        EntryContainer.secondary(
          title: 'คุณรู้สึกอย่างไร',
          trailing: GroupSelector(
            items: ['เฉยๆ', 'หงุดหงิด', 'หิว', 'เครียด', 'เศร้า', 'มีความสุข'],
            selectedItem: _entry.mood,
            onChanged: (String mood) {
              setState(() => _entry = _entry.copyWith(mood: mood));
              widget.onChange(_entry);
            },
          ),
        ),
      ],
    );
  }
}

class EntryContainer extends StatelessWidget {
  final bool primary;
  final Widget child;
  final String title;
  final Widget trailing;

  const EntryContainer({
    Key key,
    this.primary = false,
    this.child,
    this.title,
    this.trailing,
  }) : super(key: key);

  EntryContainer.primary({
    this.primary = true,
    this.child,
    this.title,
    this.trailing,
  });

  EntryContainer.secondary({
    this.primary = false,
    this.child,
    this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: this.primary ? ColorPalette.primaryBackground : Theme.of(context).scaffoldBackgroundColor,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Styles.title,
          ),
          trailing,
        ],
      ),
    );
  }
}
