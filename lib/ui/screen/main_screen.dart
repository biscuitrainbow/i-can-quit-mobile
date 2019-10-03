import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user/user_state.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_state.dart';
import 'package:i_can_quit/ui/screen/user/user_first_setting_screen.dart';
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
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final UserSettingBloc userSettingBloc = BlocProvider.of<UserSettingBloc>(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      builder: (context, authenticationState) {
        return BlocBuilder<UserSettingBloc, UserSettingState>(
          bloc: userSettingBloc,
          builder: (context, userSettingState) {
            if (authenticationState is UserAuthenticated) {
              
              if (userSettingState is FetchUserSettingSuccess) {
                return UserFirstSettingScreen();
              }

              return MainNavigationScreen();
            }

            return LoginScreen();
          },
        );
      },
    );
  }
}
