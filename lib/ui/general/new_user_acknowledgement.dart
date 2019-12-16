import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/screen/user/user_first_setting_screen.dart';

class NewUserAcknowledgement extends StatefulWidget {
  NewUserAcknowledgement({Key key}) : super(key: key);

  @override
  _NewUserAcknowledgementState createState() => _NewUserAcknowledgementState();
}

class _NewUserAcknowledgementState extends State<NewUserAcknowledgement> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            IconData(0xe7c6, fontFamily: 'iconfont'),
            color: Colors.grey.shade400,
            size: 64,
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'ยินดีต้อนรับผู้ใช้ใหม่ กรุณาป้อนข้อมูลเบื้องต้นเกี่ยวกับพฤติกรรมการสูบบุหรี่ของคุณเพื่อเริ่มใช้งาน',
              style: Styles.descriptionSecondary,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 12),
          FlatButton(
            child: Text(
              'กรอกข้อมูลเบื้องต้น',
              style: Styles.titleAccent,
            ),
            color: ColorPalette.primary,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => UserFirstSettingScreen())),
          )
        ],
      ),
    );
  }
}
