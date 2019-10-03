import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_event.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_state.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/user/user_cigarette_setup.dart';
import 'package:i_can_quit/ui/screen/user/user_path_selection_screen.dart';

class UserFirstSettingScreen extends StatefulWidget {
  @override
  _UserFirstSettingScreenState createState() => _UserFirstSettingScreenState();
}

class _UserFirstSettingScreenState extends State<UserFirstSettingScreen> with AutomaticKeepAliveClientMixin<UserFirstSettingScreen> {
  PageController _pageController = PageController();
  UserSetting _setting = UserSetting.initial();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _submit(UserSettingBloc bloc) {
    bloc.dispatch(SaveUserSetting(settings: _setting));
  }

  @override
  Widget build(BuildContext context) {
    final UserSettingBloc userSettingBloc = BlocProvider.of<UserSettingBloc>(context);

    return BlocListener<UserSettingBloc, UserSettingState>(
      listener: (context, state) {
        if (state is SaveUserSettingSuccess) {
          Navigator.of(context).pushReplacementNamed(MainNavigationScreen.route);
        }
      },
      child: Scaffold(
        body: BlocBuilder<UserSettingBloc, UserSettingState>(
          bloc: userSettingBloc,
          builder: (context, state) {
            if (state is SaveUserSettingLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                UserPathSelectionScreen(
                  onNext: (QuitingPath path) {
                    setState(() => _setting = _setting.copyWith(path: path));

                    print('next');

                    _pageController.nextPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
                  },
                ),
                UserCigaretteSettingScreen(
                  onNext: (int numberOfCigarettesPerDay, int pricePerPackage, int numberOfCigarettesPerPackage) {
                    setState(
                      () => _setting = _setting.copyWith(
                          numberOfCigarettesPerDay: numberOfCigarettesPerDay,
                          pricePerPackage: pricePerPackage,
                          numberOfCigarettesPerPackage: numberOfCigarettesPerPackage),
                    );

                    _submit(userSettingBloc);
                  },
                  onBack: () {
                    _pageController.previousPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
