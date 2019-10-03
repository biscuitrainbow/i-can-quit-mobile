import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_can_quit/bloc/app_bloc_delegate.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/news/news_bloc.dart';
import 'package:i_can_quit/bloc/register/register_bloc.dart';
import 'package:i_can_quit/bloc/smoking_entry/smoking_entry_bloc.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user_setting/user_setting_bloc.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/data/repository/news_repository.dart';
import 'package:i_can_quit/data/repository/smoking_entry_repository.dart';
import 'package:i_can_quit/data/repository/token_repository.dart';
import 'package:i_can_quit/data/repository/user_repository.dart';
import 'package:i_can_quit/data/service/authentication_service.dart';
import 'package:i_can_quit/ui/screen/main_navigation_screen.dart';
import 'package:i_can_quit/ui/screen/main_screen.dart';
import 'package:i_can_quit/ui/screen/smoking_overview.dart';
import 'package:i_can_quit/ui/screen/splash_screen.dart';
import 'package:i_can_quit/ui/screen/user/user_login_screen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/application/application_bloc.dart';
import 'bloc/authentication/authentication_event.dart';
import 'data/repository/user_setting_repository.dart';

void main() async {
  await DotEnv().load('.env');

  final BaseOptions options = BaseOptions(
    baseUrl: DotEnv().env['API_BASE_URL'],
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  final Dio dio = Dio(options);
  // dio.interceptors.add(
  //   PrettyDioLogger(
  //     requestHeader: false,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //   ),
  // );

  final FacebookLogin facebookLogin = FacebookLogin();
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final TokenRepository tokenRepository = TokenRepository(sharedPreferences);

  final AuthenticationService authenticationService = AuthenticationService(dio, tokenRepository, facebookLogin, googleSignIn);

  final UserSettingRepository userSettingRepository = UserSettingRepository(dio, tokenRepository);
  final SmokingEntryRepository smokingEntryRepository = SmokingEntryRepository(dio, tokenRepository);
  final UserRepository userRepository = UserRepository(dio, tokenRepository);
  final NewsRepository newsRepository = NewsRepository(dio, tokenRepository);

  runApp(
    Application(
      smokingEntryRepository: smokingEntryRepository,
      userSettingRepository: userSettingRepository,
      userRepository: userRepository,
      tokenRepository: tokenRepository,
      newsRepository: newsRepository,
      authenticationService: authenticationService,
    ),
  );
}

class Application extends StatelessWidget {
  final SmokingEntryRepository smokingEntryRepository;
  final UserSettingRepository userSettingRepository;
  final UserRepository userRepository;
  final TokenRepository tokenRepository;
  final NewsRepository newsRepository;
  final AuthenticationService authenticationService;

  const Application({
    Key key,
    @required this.smokingEntryRepository,
    @required this.userSettingRepository,
    @required this.userRepository,
    @required this.tokenRepository,
    @required this.newsRepository,
    @required this.authenticationService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = AppBlocDelegate();

    final smokingEntryBloc = SmokingEntryBloc(smokingEntryRepository);
    final newsBloc = NewsBloc(this.newsRepository);
    final userBloc = UserBloc(userRepository);

    final userSettingBloc = UserSettingBloc(
      userSettingRepository,
      smokingEntryRepository,
    );

    final authenticationBloc = AuthenticationBloc(
      userRepository,
      tokenRepository,
      authenticationService,
      userBloc,
      smokingEntryBloc,
      userSettingBloc,
    );

    final registrationBloc = RegistrationBloc(
      userRepository,
      tokenRepository,
      authenticationService,
      authenticationBloc,
    );

    final applicationBloc = ApplicationBloc(
      authenticationBloc,
      userBloc,
      smokingEntryBloc,
      userSettingBloc,
      newsBloc,
      registrationBloc,
    );

    authenticationBloc.dispatch(CheckAuthenticated());

    return MultiBlocProvider(
      providers: [
        BlocProvider<SmokingEntryBloc>(
          builder: (context) => smokingEntryBloc,
        ),
        BlocProvider<UserSettingBloc>(
          builder: (context) => userSettingBloc,
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
        BlocProvider<ApplicationBloc>(
          builder: (context) => applicationBloc,
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
        home: SplashScreen(),
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
