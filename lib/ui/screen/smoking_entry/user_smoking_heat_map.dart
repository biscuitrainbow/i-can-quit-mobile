import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
    return InAppWebView(
      initialUrl: "https://i-can-quit-map.firebaseapp.com/",
      onConsoleMessage: (_, message) {
        print(message.message);
      },
      initialOptions: InAppWebViewWidgetOptions(
        inAppWebViewOptions: InAppWebViewOptions(
          debuggingEnabled: true,
          javaScriptEnabled: true,
          cacheEnabled: false,
        ),
        
      ),
    );
  }
}
