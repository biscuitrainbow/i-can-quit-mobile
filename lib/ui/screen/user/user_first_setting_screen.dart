import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_event.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_state.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_event.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_state.dart';
import 'package:i_can_quit/data/model/quiting_path.dart';
import 'package:i_can_quit/data/model/smoking_entry.dart';
import 'package:i_can_quit/data/model/user_setting.dart';
import 'package:i_can_quit/ui/screen/first_times_smoking_entry_form.dart';
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/smoking_entry_form.dart';
import 'package:i_can_quit/ui/screen/user/user_cigarette_setup.dart';
import 'package:i_can_quit/ui/screen/user/user_path_selection_screen.dart';
import 'package:i_can_quit/ui/widget/smoking_entry/smoking_entry_form.dart';

class UserFirstSettingScreen extends StatefulWidget {
  @override
  _UserFirstSettingScreenState createState() => _UserFirstSettingScreenState();
}

class _UserFirstSettingScreenState extends State<UserFirstSettingScreen> with AutomaticKeepAliveClientMixin<UserFirstSettingScreen> {
  PageController _pageController = PageController();
  UserSetting _setting = UserSetting.initial();
  SmokingEntry _entry = SmokingEntry.create();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _saveUserSetting(UserSettingBloc bloc) {
    bloc.add(SaveUserSetting(settings: _setting));
  }

  void _saveFirstTimesSmokingEntry(SmokingEntryBloc bloc) {
    bloc.add(SaveSmokingEntry(entry: _entry));
  }

  @override
  Widget build(BuildContext context) {
    final UserSettingBloc userSettingBloc = BlocProvider.of<UserSettingBloc>(context);
    final SmokingEntryBloc smokingEntryBloc = BlocProvider.of<SmokingEntryBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<UserSettingBloc, UserSettingState>(listener: (context, state) {
          if (state is SaveUserSettingSuccess) {
            _pageController.nextPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
          }
        }),
        BlocListener<SmokingEntryBloc, SmokingEntryState>(listener: (context, state) {
          if (state is SaveSmokingEntrySuccess) {
            Navigator.of(context).pop();
          }
        }),
      ],
      // child: Scaffold(
      //   body: BlocBuilder<UserSettingBloc, UserSettingState>(
      //     bloc: userSettingBloc,
      //     builder: (context, state) {

      //     },
      //   ),
      // ),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            UserPathSelectionScreen(
              onNext: (QuitingPath path) {
                setState(() => _setting = _setting.copyWith(path: path));

                _pageController.nextPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
              },
            ),
            BlocBuilder<UserSettingBloc, UserSettingState>(
              bloc: userSettingBloc,
              builder: (context, state) {
                if (state is SaveUserSettingLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return UserCigaretteSettingScreen(
                  onNext: (int numberOfCigarettesPerDay, int pricePerPackage, int numberOfCigarettesPerPackage) {
                    setState(
                      () => _setting = _setting.copyWith(
                          numberOfCigarettesPerDay: numberOfCigarettesPerDay,
                          pricePerPackage: pricePerPackage,
                          numberOfCigarettesPerPackage: numberOfCigarettesPerPackage),
                    );

                    _saveUserSetting(userSettingBloc);
                  },
                  onBack: () {
                    _pageController.previousPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
                  },
                );
              },
            ),
            BlocBuilder<SmokingEntryBloc, SmokingEntryState>(
              bloc: smokingEntryBloc,
              builder: (context, state) {
                if (state is SaveSmokingEntryLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                return FirstTimesSmokingEntryScreen(
                  onSubmit: (SmokingEntry entry) {
                    setState(() {
                      _entry = entry;
                    });

                    _saveFirstTimesSmokingEntry(smokingEntryBloc);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
