import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/ui/widget/button/expanded_button.dart';
import 'package:i_can_quit/ui/widget/container/vertical_divided_column.dart';
import 'package:i_can_quit/ui/widget/smoking_entry/smoking_entry_form.dart';

class SmokingEntryFormScreen extends StatefulWidget {
  SmokingEntryFormScreen({Key key}) : super(key: key);

  _SmokingEntryFormScreenState createState() => _SmokingEntryFormScreenState();
}

class _SmokingEntryFormScreenState extends State<SmokingEntryFormScreen> {
  SmokingEntry _entry = SmokingEntry.create();

  void _submit(SmokingEntryBloc bloc) {
    bloc.add(SaveSmokingEntry(entry: _entry));
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
        child: BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
          bloc: smokingEntryBloc,
          builder: (context, state) {
            if (state is SaveSmokingEntryLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return VerticalDividedColumn(
              top: SmokingEntryForm(
                onChange: (entry) => setState(() => _entry = entry),
              ),
              bottom: ExpandedButton(
                title: 'บันทึก',
                onPressed: () => _submit(smokingEntryBloc),
              ),
            );
          },
        ),
      ),
    );
  }
}
