import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/screen/user/user_cigarette_setup.dart';
import 'package:i_can_quit/ui/widget/selector/selector_group.dart';

class UserSettingScreen extends StatefulWidget {
  static final String route = "/user_setting";

  UserSettingScreen({Key key}) : super(key: key);

  @override
  _UserSettingScreenState createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  final _pricePerPackages = [for (var i = 50; i <= 120; i = i + 5) i].map((number) => number.toString()).toList();
  final _numberOfCigarettesPerDays = [for (var i = 1; i <= 30; i++) i].map((number) => number.toString()).toList();
  final _numberOfCigarettesPerPackages = [for (var i = 15; i <= 30; i++) i].map((number) => number.toString()).toList();

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
    super.dispose();

    _pricePerPackageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่า'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ในแต่ละวันคุณสูบบุหรี่กี่มวน',
              style: Styles.headerSectionPrimary,
            ),
            GroupSelector(
              items: _numberOfCigarettesPerDays,
              selectedItem: numberOfCigarettesPerDay.toString(),
              warp: false,
              onChanged: (String number) => setState(() => numberOfCigarettesPerDay = int.parse(number)),
            ),
            SizedBox(height: 28),
            Text(
              'บุหรี่หนึ่งซองราคาเท่าไหร่',
              style: Styles.headerSectionPrimary,
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
              style: Styles.headerSectionPrimary,
            ),
            GroupSelector(
              items: _numberOfCigarettesPerPackages,
              selectedItem: numberOfCigarettesPerPackage.toString(),
              warp: false,
              onChanged: (String number) => setState(() => numberOfCigarettesPerPackage = int.parse(number)),
            ),
          ],
        ),
      ),
    );
  }
}
