import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:i_can_quit/bloc/authentication/authentication_bloc.dart';
import 'package:i_can_quit/bloc/authentication/authentication_state.dart';
import 'package:i_can_quit/bloc/user/user_bloc.dart';
import 'package:i_can_quit/bloc/user/user_event.dart';
import 'package:i_can_quit/bloc/user/user_state.dart';

class UserSmokingHeatMap extends StatefulWidget {
  @override
  _UserSmokingHeatMapState createState() => _UserSmokingHeatMapState();
}

class _UserSmokingHeatMapState extends State<UserSmokingHeatMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
      if (state is UserAuthenticated) {
        return InAppWebView(
          initialUrl: "https://i-can-quit-map.firebaseapp.com/heatmap/user/${state.token}",
          initialOptions: InAppWebViewWidgetOptions(
            inAppWebViewOptions: InAppWebViewOptions(
              debuggingEnabled: true,
              javaScriptEnabled: true,
              cacheEnabled: false,
            ),
          ),
        );
      }

      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
