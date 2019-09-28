import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/register/register_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/user_first_setup/user_first_setup_bloc.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/repository/news_repository.dart';
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
import 'bloc/news/news_event.dart';
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

  final UserSetupRepository userSetupRepository = UserSetupRepository(dio, tokenRepository);
  final SmokingEntryRepository smokingEntryRepository = SmokingEntryRepository(dio, tokenRepository);
  final UserRepository userRepository = UserRepository(dio, tokenRepository);
  final NewsRepository newsRepository = NewsRepository(dio, tokenRepository);

  runApp(
    Application(
      smokingEntryRepository: smokingEntryRepository,
      userSetupRepository: userSetupRepository,
      userRepository: userRepository,
      tokenRepository: tokenRepository,
      newsRepository: newsRepository,
    ),
  );
}

class Application extends StatelessWidget {
  final SmokingEntryRepository smokingEntryRepository;
  final UserSetupRepository userSetupRepository;
  final UserRepository userRepository;
  final TokenRepository tokenRepository;
  final NewsRepository newsRepository;

  const Application({
    Key key,
    @required this.smokingEntryRepository,
    @required this.userSetupRepository,
    @required this.userRepository,
    @required this.tokenRepository,
    @required this.newsRepository,
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
        BlocProvider<NewsBloc>(
          builder: (context) => NewsBloc(this.newsRepository)..dispatch(FetchNews()),
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
