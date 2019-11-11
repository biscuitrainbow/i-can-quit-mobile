import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/assets.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:i_can_quit/ui/screen/about/organization_item.dart';

class AboutScreen extends StatefulWidget {
  static final String route = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('เกี่ยวกับ'),
          elevation: 0.3,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          children: <Widget>[
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     // Icon(
            //     //   AssetIcon.salt,
            //     //   color: Theme.of(context).primaryColor,
            //     //   size: 60.0,
            //     // ),
            //     SizedBox(width: 20.0),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text(
            //           'iCanQuit',
            //           textAlign: TextAlign.center,
            //           style: Styles.title,
            //         ),
            //         // Text(
            //         //   'เค็มพอดี ชีวีมีสุข',
            //         //   textAlign: TextAlign.center,
            //         //   style: Styles.description,
            //         // ),
            //       ],
            //     )
            //   ],
            // ),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'คณะผู้วิจัย',
                      textAlign: TextAlign.center,
                      style: Styles.title,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'ผศ.ดร.เบญจมาศ สุขสถิตย์',
                      nameEnglish: 'คณะพยาบาลศาสตร์ มหาวิทยาลัยเชียงใหม่',
                      imageAsset: AssetImages.logoNursing,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระราชปริยัติ, รศ.ดร.',
                      nameEnglish: 'มหาวิทยาลัยมหาจุฬาลงกรณราชวิทยาลัย วิทยาเขตพะเยา',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'ที่ปรึกษา',
                      textAlign: TextAlign.center,
                      style: Styles.title,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระพรหมเสนาบดี',
                      nameEnglish: 'เจ้าอาวาสวัดปทุมคงคาราชวรวิหาร เจ้าคณะภาค ๗ และ ประธานคณะกรรมการฯ "หมู่บ้านรักษาศีล ๕"',
                      imageAsset: AssetImages.logoSFive,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระเทพเวที, รศ.ดร.',
                      nameEnglish:
                          'ผู้รักษาการเจ้าคณะภาค ๖ รองอธิการบดีฝ่ายกิจการนิสิต มหาวิทยาลัยมหาจุฬาลกรณราชวิทยาลัย และ ผู้ช่วยเจ้าอาวาสวัดสังเวชวิศยารามวรวิหาร',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระสุธีรัตนบัณฑิต, รศ.ดร.',
                      nameEnglish: 'มหาวิทยาลัยมหาจุฬาลงกรณราชวิทยาลัย',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'ศ.ดร.วิภาดา คุณาวิกติกุล',
                      nameEnglish: 'คณะพยาบาลศาสตร์ มหาวิทยาลัยเชียงใหม่',
                      imageAsset: AssetImages.logoNursing,
                    ),
                    SizedBox(height: 16.0),
                    // Text(
                    //   'พัฒนาโดย',
                    //   textAlign: TextAlign.center,
                    //   style: Styles.title,
                    // ),
                    // SizedBox(height: 16.0),
                    // Text(
                    //   'นายณัฐพล ศรีโคตร',
                    //   textAlign: TextAlign.left,
                    //   style: Styles.title,
                    // ),
                    // Text(
                    //   'Embedded System & Mobile Application Laboratory',
                    //   style: Styles.description,
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
