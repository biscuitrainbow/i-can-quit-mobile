import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_rounded_date_picker/cupertino_rounded_date_picker.dart';
import 'package:flutter_rounded_date_picker/era_mode.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/ui/widget/button/expanded_button.dart';
import 'package:i_can_quit/ui/widget/container/vertical_divided_column.dart';
import 'package:i_can_quit/ui/widget/selector/selector_group.dart';
import 'package:intl/intl.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

class SmokingEntryFormScreen extends StatefulWidget {
  SmokingEntryFormScreen({Key key}) : super(key: key);

  _SmokingEntryFormScreenState createState() => _SmokingEntryFormScreenState();
}

class _SmokingEntryFormScreenState extends State<SmokingEntryFormScreen> {
  SmokingEntry _entry = SmokingEntry.create();

  void _submit(SmokingEntryBloc bloc) {
    bloc.dispatch(SaveSmokingEntry(entry: _entry));
  }

  @override
  Widget build(BuildContext context) {
    final SmokingEntryBloc smokingEntryBloc = BlocProvider.of<SmokingEntryBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างบันทึก',
          style: TextStyle(color: ColorPalette.primary),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: BlocListener<SmokingEntryBloc, SmokingEntryState>(
        listener: (context, state) {
          if (state is SaveSmokingEntrySuccess) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('บันทึกสำเร็จ', style: TextStyle(fontFamily: 'Kanit'))));
          }
        },
        child: VerticalDividedColumn(
          top: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EntryContainer.secondary(
                title: "รู้สึกอยากสูบมากแค่ไหน",
                trailing: GroupSelector(
                  items: ['ไม่เลย', 'น้อย', 'ปานกลาง', 'มาก', 'ควบคุมไม่ได้'],
                  selectedItem: _entry.smokingNeededLevel,
                  onChanged: (String neededLevel) => setState(() => _entry = _entry.copyWith(smokingNeededLevel: neededLevel)),
                ),
              ),
              EntryContainer.primary(
                title: 'คุณได้สูบบุหรี่ไปหรือไม่',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(_entry.hasSmoked ? "สูบ" : "ไม่ได้สูบ", style: TextStyle(color: ColorPalette.detail)),
                    Switch(
                      value: _entry.hasSmoked,
                      onChanged: (bool smoked) => setState(() => _entry = _entry.copyWith(hasSmoked: smoked)),
                    )
                  ],
                ),
              ),
              EntryContainer.secondary(
                title: 'วันที่บันทึก',
                trailing: GestureDetector(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(DateFormat('dd MMM yyyy', 'th').format(_entry.datetime), style: TextStyle(color: ColorPalette.detail)),
                    ],
                  ),
                  onTap: () => {
                    CupertinoRoundedDatePicker.show(
                      context,
                      era: EraMode.BUDDHIST_YEAR,
                      fontFamily: "Kanit",
                      borderRadius: 16,
                      initialDatePickerMode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (datetime) => setState(() => _entry = _entry.copyWith(datetime: datetime)),
                    )
                  },
                ),
              ),
              EntryContainer.primary(
                title: 'สถานที่',
                trailing: IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () async {
                    final locationResult = await LocationPicker.pickLocation(context, DotEnv().env['GOOGLE_MAP_API_KEY']);

                    print(locationResult);

                    if (locationResult != null) {
                      setState(() {
                        _entry = _entry.copyWith(location: locationResult.latLng);
                      });
                    }
                  },
                ),
              ),
              EntryContainer.secondary(
                title: 'คุณรู้สึกอย่างไรในตอนนี้',
                trailing: GroupSelector(
                  items: ['หงุดหงิด', 'หิว', 'เครียด', 'เศร้า', 'มีความสุข'],
                  selectedItem: _entry.mood,
                  onChanged: (String mood) => setState(() => _entry = _entry.copyWith(mood: mood)),
                ),
              ),
            ],
          ),
          bottom: ExpandedButton(
            title: 'บันทึก',
            onPressed: () => _submit(smokingEntryBloc),
          ),
        ),
      ),
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
            style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
          ),
          trailing,
        ],
      ),
    );
  }
}
