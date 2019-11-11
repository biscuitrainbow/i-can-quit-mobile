import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';
import 'package:i_can_quit/ui/widget/smoking_entry/smoking_entry_form.dart';

class FirstTimesSmokingEntryScreen extends StatefulWidget {
  final Function(SmokingEntry entry) onSubmit;

  const FirstTimesSmokingEntryScreen({Key key, this.onSubmit}) : super(key: key);

  @override
  _FirstTimesSmokingEntryScreenState createState() => _FirstTimesSmokingEntryScreenState();
}

class _FirstTimesSmokingEntryScreenState extends State<FirstTimesSmokingEntryScreen> {
  SmokingEntry _entry = SmokingEntry.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'กรอกบันทึกการสูบบุหรี่ครั้งล่าสุดของคุณ',
                style: Styles.titlePrimary,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'เพื่อให้เราสามารถช่วยคุณลดบุหรี่ได้ง่ายขึ้น',
                  textAlign: TextAlign.center,
                  style: Styles.descriptionSecondary,
                ),
              ),
              SizedBox(height: 8),
              SmokingEntryForm(
                firstTimesEntry: true,
                onChange: (entry) => setState(() => _entry = entry),
              ),
              SizedBox(height: 8),
              RippleButton(
                text: 'เสร็จสิ้น',
                backgroundColor: Colors.green,
                textColor: Colors.white,
                decoration: Styles.primaryButtonDecoration,
                onPress: () => this.widget.onSubmit(_entry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
