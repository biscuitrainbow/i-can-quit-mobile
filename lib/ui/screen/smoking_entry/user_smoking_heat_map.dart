import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    return Scaffold(
      body: WebView(
        initialUrl: 'https://i-can-quit-map.firebaseapp.com/',
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
      ),
    );
  }
}
