import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/assets.dart';

import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  static final String route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(duration: Duration(seconds: 5), vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainScreen()));
        }
      });
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   'iCanQuit',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     color: Theme.of(context).primaryColor,
                  //     fontSize: 36.0,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // SvgPicture.asset(
                  //   'assets/logo/brand.svg',
                  //   semanticsLabel: 'Acme Logo',
                  //   width: 350,
                  // )
                  Image.asset(
                    AssetImages.logoApp,
                    width: 256,
                  ),
                  // Text(
                  //   'เค็มพอดี ชีวีมีสุข',
                  //   textAlign: TextAlign.center,
                  //   // style: Style.description.copyWith(
                  //   //   fontSize: 20.0,
                  //   //   color: Colors.grey.shade600,
                  //   // ),
                  // ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'ได้รับงบประมาณสนับสนุนจาก',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Image.asset(AssetImages.logoSSS, width: 80.0),
                SizedBox(height: 32.0),
              ],
            ),
            // Stack(
            //   alignment: Alignment.bottomCenter,
            //   children: <Widget>[
            //     Container(
            //       height: 80.0,
            //       child: WaveWidget(
            //         config: CustomConfig(
            //           colors: [
            //             Theme.of(context).primaryColor,
            //             Color(0xFF00A765),
            //             Color(0xFF45D99F),
            //             Color(0xFFA2ECCF),
            //           ],
            //           durations: [
            //             32000,
            //             21000,
            //             18000,
            //             5000,
            //           ],
            //           heightPercentages: [
            //             0.18,
            //             0.26,
            //             0.28,
            //             0.40,
            //           ],
            //           blur: MaskFilter.blur(BlurStyle.solid, 5),
            //         ),
            //         size: Size(double.infinity, double.infinity),
            //         waveAmplitude: 0,
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
