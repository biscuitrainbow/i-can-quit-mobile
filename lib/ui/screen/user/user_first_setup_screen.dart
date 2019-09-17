import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_event.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/data/model/user_first_setup.dart';
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/main_screen.dart';
import 'package:i_can_quit/ui/screen/user/user_cigarette_setup.dart';
import 'package:i_can_quit/ui/screen/user/user_path_selection_screen.dart';

import '../smoking_overview.dart';

class UserFirstSetupScreen extends StatefulWidget {
  @override
  _UserFirstSetupScreenState createState() => _UserFirstSetupScreenState();
}

class _UserFirstSetupScreenState extends State<UserFirstSetupScreen> with AutomaticKeepAliveClientMixin<UserFirstSetupScreen> {
  PageController _pageController = PageController();
  UserSetup _setup = UserSetup.initial();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _submit(UserFirstSetupBloc bloc) {
    bloc.dispatch(SaveUserFirstSetup(setup: _setup));

    Navigator.of(context).pushReplacementNamed(MainNavigationScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final UserFirstSetupBloc userFirstSetupBloc = BlocProvider.of<UserFirstSetupBloc>(context);

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          UserPathSelectionScreen(
            onNext: (QuitingPath path) {
              setState(() => _setup = _setup.copyWith(path: path));

              print('next');

              _pageController.nextPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
            },
          ),
          UserCigaretteSetupScreen(
            onNext: (int numberOfCigarettesPerDay, int pricePerPackage, int numberOfCigarettesPerPackage) {
              setState(
                () => _setup = _setup.copyWith(
                    numberOfCigarettesPerDay: numberOfCigarettesPerDay,
                    pricePerPackage: pricePerPackage,
                    numberOfCigarettesPerPackage: numberOfCigarettesPerPackage),
              );

              _submit(userFirstSetupBloc);
            },
            onBack: () {
              _pageController.previousPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
            },
          ),
        ],
      ),
    );
  }
}
