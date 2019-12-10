import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/ui/screen/introduction_screen.dart';
import 'package:i_can_quit/ui/screen/splash_screen.dart';
import 'package:i_can_quit/ui/screen/user/user_login_screen.dart';

import 'main_navigation_screen.dart';

class MainScreen extends StatefulWidget {
  static const route = '/main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UserAuthenticated) {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroductionScreen()));
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplashScreen()));
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authenticationState) {
          if (authenticationState is UserAuthenticated) {
            return MainNavigationScreen();
          }

          return LoginScreen();
        },
      ),
    );
  }
}
