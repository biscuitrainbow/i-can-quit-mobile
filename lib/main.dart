import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/main_screen.dart';
import 'package:i_can_quit/ui/screen/smoking_overview.dart';
import 'package:i_can_quit/ui/screen/user/user_login_screen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
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
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );

  final FacebookLogin facebookLogin = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final TokenRepository tokenRepository = TokenRepository(sharedPreferences);

  final UserSetupRepository userSetupRepository = UserSetupRepository(dio, tokenRepository);
  final SmokingEntryRepository smokingEntryRepository = SmokingEntryRepository(dio, tokenRepository);
  final UserRepository userRepository = UserRepository(dio, tokenRepository, facebookLogin, googleSignIn);
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
    final authenticationBloc = AuthenticationBloc(userRepository, tokenRepository);
    final registrationBloc = RegistrationBloc(userRepository, tokenRepository, authenticationBloc);
    final smokingEntryBloc = SmokingEntryBloc(smokingEntryRepository);
    final userSetupBloc = UserFirstSetupBloc(userSetupRepository, authenticationBloc, smokingEntryRepository);
    final newsBloc = NewsBloc(this.newsRepository);

    authenticationBloc.dispatch(CheckAuthenticated());
    smokingEntryBloc.dispatch(FetchSmokingEntry());
    newsBloc.dispatch(FetchNews());

    return MultiBlocProvider(
      providers: [
        BlocProvider<SmokingEntryBloc>(
          builder: (context) => smokingEntryBloc,
        ),
        BlocProvider<UserFirstSetupBloc>(
          builder: (context) => userSetupBloc,
        ),
        BlocProvider<NewsBloc>(
          builder: (context) => newsBloc,
        ),
        BlocProvider<AuthenticationBloc>(
          builder: (context) => authenticationBloc,
        ),
        BlocProvider<RegistrationBloc>(
          builder: (context) => registrationBloc,
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
