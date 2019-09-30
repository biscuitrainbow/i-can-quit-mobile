import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/user/user_login_screen.dart';

class MainScreen extends StatefulWidget {
  static const route = '/main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
      builder: (context, state) {
        if (state is UserAuthenticated) {
          // return UserFirstSetupScreen();
          return MainNavigationScreen();
        }

        return LoginScreen();
      },
    );
  }
}
