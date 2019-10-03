import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user/user_state.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_state.dart';
import 'package:i_can_quit/ui/screen/user/user_first_setup_screen.dart';
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
    final UserSetupBloc userSetupBloc = BlocProvider.of<UserSetupBloc>(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      builder: (context, authenticationState) {
        return BlocBuilder<UserSetupBloc, UserFirstSetupState>(
          bloc: userSetupBloc,
          builder: (context, userSetupState) {
            if (authenticationState is UserAuthenticated) {
              
              if (userSetupState is FetchUserSetupSuccess) {
                return UserFirstSetupScreen();
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
