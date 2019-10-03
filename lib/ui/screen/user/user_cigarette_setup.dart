import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/widget/button/ripple_button.dart';
import 'package:i_can_quit/ui/widget/selector/selector_group.dart';

class UserCigaretteSettingScreen extends StatefulWidget {
  final Function(int, int, int) onNext;
  final Function onBack;

  const UserCigaretteSettingScreen({Key key, this.onNext, this.onBack}) : super(key: key);

  @override
  _UserCigaretteSettingScreenState createState() => _UserCigaretteSettingScreenState();
}

class _UserCigaretteSettingScreenState extends State<UserCigaretteSettingScreen> with AutomaticKeepAliveClientMixin<UserCigaretteSettingScreen> {
  final _pricePerPackages = [for (var i = 50; i <= 120; i = i + 5) i].map((number) => number.toString()).toList();

  int numberOfCigarettesPerDay = 5;
  int numberOfCigarettesPerPackage = 15;
  int pricePerPackage = 50;

  TextEditingController _pricePerPackageController;

  @override
  void initState() {
    super.initState();
    _pricePerPackageController = TextEditingController(text: _pricePerPackages.first.toString());
  }

  @override
  void dispose() {
    _pricePerPackageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ในแต่ละวันคุณสูบบุหรี่กี่มวน',
                style: Styles.titlePrimary,
              ),
              GroupSelector(
                items: [for (var i = 1; i <= 30; i++) i].map((number) => number.toString()).toList(),
                selectedItem: numberOfCigarettesPerDay.toString(),
                warp: false,
                onChanged: (String number) => setState(() => numberOfCigarettesPerDay = int.parse(number)),
              ),
              SizedBox(height: 28),
              Text(
                'บุหรี่หนึ่งซองราคาเท่าไหร่',
                style: Styles.titlePrimary,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: GroupSelector(
                      items: _pricePerPackages,
                      selectedItem: pricePerPackage.toString(),
                      warp: false,
                      onChanged: (String number) => setState(() {
                        pricePerPackage = int.parse(number);
                        _pricePerPackageController.text = number;
                      }),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Text('หรือ', style: Styles.descriptionSecondary),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _pricePerPackageController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (String number) => setState(() => pricePerPackage = int.parse(number)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Text(
                'จำนวนบุหรี่ในหนึ่งซอง',
                style: Styles.titlePrimary,
              ),
              GroupSelector(
                items: [for (var i = 15; i <= 30; i++) i].map((number) => number.toString()).toList(),
                selectedItem: numberOfCigarettesPerPackage.toString(),
                warp: false,
                onChanged: (String number) => setState(() => numberOfCigarettesPerPackage = int.parse(number)),
              ),
              SizedBox(height: 125),
              RippleButton(
                text: 'เสร็จสิ้น',
                backgroundColor: Colors.green,
                textColor: Colors.white,
                decoration: Styles.primaryButtonDecoration,
                onPress: () => this.widget.onNext(numberOfCigarettesPerDay, pricePerPackage, numberOfCigarettesPerPackage),
              ),
              RippleButton(
                text: 'ย้อนกลับ',
                textColor: ColorPalette.primary,
                onPress: () => this.widget.onBack(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
