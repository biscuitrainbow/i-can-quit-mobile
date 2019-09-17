import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/register/register_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_bloc.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/main_screen.dart';
import 'package:i_can_quit/ui/screen/smoking_overview.dart';
import 'package:i_can_quit/ui/screen/user/user_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/authentication/authentication_event.dart';
import 'bloc/smoking_entry/smoking_entry_event.dart';
import 'data/repository/user_setup_repository.dart';

void main() async {
  await DotEnv().load('.env');

  final BaseOptions options = BaseOptions(
    baseUrl: DotEnv().env['API_BASE_URL'],
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  final Dio dio = Dio(options);

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final TokenRepository tokenRepository = TokenRepository(sharedPreferences);
  // await tokenRepository.saveToken(
  //     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1YTcyZDVjM2UxZWM4OTU0ZmQwMzdkYmRmOThiYzliMTBkODI4ODRjZjg1ODY5M2Y4YjY3ODQ0MzlhNDkwZTE3ZmUwZjMyYWE5NTNiZTZjIn0.eyJhdWQiOiIxIiwianRpIjoiNjVhNzJkNWMzZTFlYzg5NTRmZDAzN2RiZGY5OGJjOWIxMGQ4Mjg4NGNmODU4NjkzZjhiNjc4NDQzOWE0OTBlMTdmZTBmMzJhYTk1M2JlNmMiLCJpYXQiOjE1Njg2NzcyMDksIm5iZiI6MTU2ODY3NzIwOSwiZXhwIjoxNjAwMjk5NjA5LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.XSssPVpRvg8AQpf_5yG47bqLMacu7lLIXd_okJAnu-6uhi_Ei60DpGsHErD6WkiPoQe5yEE6S0gihh80TocYOdGU-J7NAPjnaDfJlbXblvF6QquVTyKW_MhD7Vk2XR-VwX4hmGzXk8l9cpkJSJaPlFtEDzLwm-4Ebo9k--vRMWZHd5ItmAF0xol3Wuk2F3Q4e6OJsXCJ7c1Y-QAAwQouK5-k62qyOyfqroqBl7oJoKQyJK47abbreMaZP1-Bha8avar5W_HoE_mXl6RyS30bSfNPDtNqMgSJkoe0v_lnsgexeT9HxWDvF7MVHvWXUnrtrWXMT4tSLd-_6n6m9L3slj3Mu26JpLH2zyJQHlEjAD4pQoxI4wjlf8g7DFZMz9sHYL8qX95blxKxdbqjr6oP7ESB6k3IijXSS6w3h1bfzeNbCz9WSWbvqbuTXjBfihWXvEMC1DMiGfVcyXcDdHcKpx5EzkFVISCYzA1kD3nFSoruK4_Guq7smpknNSmg_LcvzWla5pA_P-yV7yhqY9AqDJFaJPJoas4PpVOfK1U6r7ABmF8N1kG1R9oHuViW7OJB_0GukBhaI2hvt049j1KNifnG7bHGNfx9-u2qkg6H0UF_ajF27ZnT2BvgX6muCz_t1PA68NFObXrC9gSdEKNiSxhcVjhSpCIbFD14gG8u5H4');

  final UserSetupRepository userSetupRepository = UserSetupRepository(dio, tokenRepository);
  final SmokingEntryRepository smokingEntryRepository = SmokingEntryRepository(dio, tokenRepository);
  final UserRepository userRepository = UserRepository(dio, tokenRepository);

  runApp(
    Application(
      smokingEntryRepository: smokingEntryRepository,
      userSetupRepository: userSetupRepository,
      userRepository: userRepository,
      tokenRepository: tokenRepository,
    ),
  );
}

class Application extends StatelessWidget {
  final SmokingEntryRepository smokingEntryRepository;
  final UserSetupRepository userSetupRepository;
  final UserRepository userRepository;
  final TokenRepository tokenRepository;

  const Application({
    Key key,
    @required this.smokingEntryRepository,
    @required this.userSetupRepository,
    @required this.userRepository,
    @required this.tokenRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SmokingEntryBloc>(
          builder: (context) => SmokingEntryBloc(this.smokingEntryRepository)..dispatch(FetchSmokingEntry()),
        ),
        BlocProvider<UserFirstSetupBloc>(
          builder: (context) => UserFirstSetupBloc(this.userSetupRepository),
        ),
        BlocProvider<AuthenticationBloc>(
          builder: (context) => AuthenticationBloc(userRepository, tokenRepository)..dispatch(AuthenticationCheck()),
        ),
        BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository, tokenRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: ColorPalette.primary,
          accentColor: ColorPalette.primary,
          fontFamily: 'Kanit',
          textTheme: Theme.of(context).textTheme.copyWith(
                title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('th', 'TH'), // Current locale
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('th', 'TH'), // Thai
        ],
        home: MainScreen(),
        routes: {
          SmokingOverviewScreen.route: (_) => SmokingOverviewScreen(),
          LoginScreen.route: (_) => LoginScreen(),
          MainScreen.route: (_) => MainScreen(),
          MainNavigationScreen.route: (_) => MainNavigationScreen(),
        },
      ),
    );
  }
}
