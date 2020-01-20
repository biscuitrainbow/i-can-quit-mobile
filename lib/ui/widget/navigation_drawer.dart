import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/screen/about/about_screen.dart';
import 'package:i_can_quit/ui/screen/introduction_screen.dart';
import 'package:i_can_quit/ui/user_setting/user_setting_screen.dart';
import 'package:i_can_quit/ui/widget/navigation/navigation_tile.dart';
import 'package:i_can_quit/ui/widget/section_divider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              SizedBox(height: 32.0),
              ListTile(
                title: Text('iCanQuit', style: Styles.headerPrimary),
              ),
              SectionDivider(),
              NavigationTile(
                icon: FontAwesomeIcons.user,
                title: 'ตั้งค่า',
                onTap: () => Navigator.of(context).pushNamed(UserSettingScreen.route),
              ),
              NavigationTile(
                icon: FontAwesomeIcons.infoCircle,
                title: 'เกี่ยวกับ',
                onTap: () => Navigator.of(context).pushNamed(AboutScreen.route),
              ),
              NavigationTile(
                icon: FontAwesomeIcons.book,
                title: 'สาระน่ารู้เกี่ยวกับบุหรี่',
                onTap: () => Navigator.of(context).pushNamed(IntroductionScreen.route),
              ),
              NavigationTile(
                icon: FontAwesomeIcons.phone,
                title: 'สายด่วนเลิกบุหรี่',
                onTap: () => launch('tel:1600'),
              )
            ],
          ),
        ),
        // NavigationTile(
        //   icon: FontAwesomeIcons.infoCircle,
        //   title: 'เกี่ยวกับ',
        //   onTap: () => Navigator.of(context).pushNamed(AboutScreen.route),
        // )
      ],
    );
  }
}
