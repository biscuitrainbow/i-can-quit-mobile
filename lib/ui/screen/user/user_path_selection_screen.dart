import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';
import 'package:i_can_quit/ui/widget/selector/path_selector.dart';

class UserPathSelectionScreen extends StatefulWidget {
  final Function(QuitingPath) onNext;

  const UserPathSelectionScreen({Key key, this.onNext}) : super(key: key);

  @override
  _UserPathSelectionScreenState createState() => _UserPathSelectionScreenState();
}

class _UserPathSelectionScreenState extends State<UserPathSelectionScreen> with AutomaticKeepAliveClientMixin<UserPathSelectionScreen> {
  QuitingPath _path = QuitingPath.slowyQuit;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'เลือกเส้นทางสู่ความสำเร็จ',
                style: Styles.titlePrimary,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'เลือกวิธีการที่เหมาะสมกับคุณเพื่อประสิทธิภาพในการเลิกบุหรี่ที่ดีที่สุด',
                  textAlign: TextAlign.center,
                  style: Styles.descriptionSecondary,
                ),
              ),
              SizedBox(height: 64),
              PathSelector(
                title: 'ค่อยๆลดวันละมวน',
                description: 'เลือกวิธีการที่เหมาะสมกับคุณเพื่อประสิทธิภาพในการเลิกบุหรี่ที่ดีที่สุด',
                selected: _path == QuitingPath.slowyQuit,
                onSelected: () {
                  setState(() {
                    _path = QuitingPath.slowyQuit;
                  });
                },
              ),
              SizedBox(height: 28),
              PathSelector(
                title: 'เลิกขาดทันที',
                description: 'เลือกวิธีการที่เหมาะสมกับคุณเพื่อประสิทธิภาพในการเลิกบุหรี่ที่ดีที่สุด',
                selected: _path == QuitingPath.suddenlyQuit,
                onSelected: () {
                  setState(() {
                    _path = QuitingPath.suddenlyQuit;
                  });
                },
              ),
              SizedBox(height: 64),
              RippleButton(
                text: 'ต่อไป',
                backgroundColor: Colors.green,
                textColor: Colors.white,
                decoration: Styles.primaryButtonDecoration,
                onPress: () => this.widget.onNext(_path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
