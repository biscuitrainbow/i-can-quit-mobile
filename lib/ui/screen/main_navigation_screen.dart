import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/ui/screen/introduction_screen.dart';
import 'package:i_can_quit/ui/screen/news/news_list_screen.dart';
import 'package:i_can_quit/ui/screen/smoking_entry/smoking_entry_insight_screen.dart';
import 'package:i_can_quit/ui/screen/smoking_entry_form.dart';
import 'package:i_can_quit/ui/screen/smoking_overview.dart';

class MainNavigationScreen extends StatefulWidget {
  static const route = '/main_navigation';
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentScreen = 0;

  void _changeScreen(int index) {
    setState(() => _currentScreen = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SmokingOverviewScreen(),
      SmokingEntryFormScreen(),
      SmokingEntryInsightScreen(),
      NewsListScreen(),
    ];

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // if (state is UserAuthenticated) {
        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroductionScreen()));
        // }
      },
      child: Scaffold(
        body: screens[_currentScreen],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentScreen,
          items: [
            BottomNavigationBarItem(title: Text('ภาพรวม'), icon: Icon(Icons.pie_chart_outlined)),
            BottomNavigationBarItem(title: Text('บันทึก'), icon: Icon(Icons.edit)),
            BottomNavigationBarItem(title: Text('ข้อมูลเชิงลึก'), icon: Icon(FontAwesomeIcons.chartLine)),
            BottomNavigationBarItem(title: Text('ข่าวสาร'), icon: Icon(FontAwesomeIcons.newspaper))
          ],
          onTap: _changeScreen,
        ),
      ),
    );
  }
}
