import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_can_quit/constant/assets.dart';
import 'package:i_can_quit/constant/color-palette.dart';
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
          title: Text(
            'เกี่ยวกับ',
            style: GoogleFonts.kanit(),
          ),
          elevation: 0.3,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          children: <Widget>[
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AssetImages.logoAppText,
                  width: 150,
                ),
                SizedBox(height: 8),
                Text(
                  'หยุดบุหรี่: ตั้งใจ ทำได้',
                  textAlign: TextAlign.center,
                  style: Styles.title,
                ),
              ],
            ),
            SizedBox(height: 16),
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
                      style: Styles.headerSection,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระราชปริยัติ, รศ.ดร.',
                      nameEnglish: 'มหาวิทยาลัยมหาจุฬาลงกรณราชวิทยาลัย วิทยาเขตพะเยา',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระครูพิศาลสรกิจ, ผศ.ดร.',
                      nameEnglish: 'มหาวิทยาลัยมหาจุฬาลงกรณราชวิทยาลัย วิทยาเขตพะเยา',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'ผศ.ดร.เบญจมาศ สุขสถิตย์',
                      nameEnglish: 'คณะพยาบาลศาสตร์ มหาวิทยาลัยเชียงใหม่',
                      imageAsset: AssetImages.logoNursing,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'นางสาวชมพูนุท สิงห์มณี',
                      nameEnglish: 'คณะพยาบาลศาสตร์ วิทยาลัยเชียงราย',
                      imageAsset: AssetImages.logoNursingChiangRai,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'นายวโรดม เสมอเชื้อ',
                      nameEnglish: 'คณะพยาบาลศาสตร์แมคคอร์มิค มหาวิทยาลัยพายัพ',
                      imageAsset: AssetImages.logoNursingPayap,
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'ที่ปรึกษา',
                      textAlign: TextAlign.center,
                      style: Styles.headerSection,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระพรหมเสนาบดี',
                      nameEnglish:
                          'กรรมการมหาเถรสมาคม \nเจ้าอาวาสวัดปทุมคงคาราชวรวิหาร เจ้าคณะภาค ๗ \nและ ประธานคณะกรรมการฯ "หมู่บ้านรักษาศีล ๕"',
                      imageAsset: AssetImages.logoSFive,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระเทพปวรเมธี, รศ.ดร',
                      nameEnglish:
                          'ผจล. และประธานองค์การศึกษา วัดประยุรวงศาวาสวรวิหาร\nรองอธิการบดีฝ่ายบริหารมหาวิทยาลัยมหาจุฬาลงกรณราชวิทยาลัย ประธาน คปพ.',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระเทพเวที, รศ.ดร.',
                      nameEnglish:
                          'เจ้าคณะภาค ๖ \nรองอธิการบดีฝ่ายกิจการนิสิต\nมหาวิทยาลัยมหาจุฬาลกรณราชวิทยาลัย และ ผู้ช่วยเจ้าอาวาสวัดสังเวชวิศยารามวรวิหาร',
                      imageAsset: AssetImages.logoMcu,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'พระศรีสมโพธิ, ดร.',
                      nameEnglish:
                          'ผู้จัดการโครงการเสริมสร้างสุขภาวะและเครือข่ายทางสังคมเพื่อลดปัจจัยเสี่ยงเชิงพุทธบูรณาการ เลขานุการรองเจ้าคณะภาค ๔ ผู้ช่วยเจ้าอาวาสวัดปากน้ำ พระอารามหลวง',
                      imageAsset: AssetImages.logoSFive,
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
                    OrganizationItem(
                      nameThai: 'รศ.ดร.ชลวิทย์​ เจียรจิตต์',
                      nameEnglish: 'คณะสังคมศาสตร์​ มหาวิทยาลัย​ศรีนครินทรวิโรฒ',
                      imageAsset: AssetImages.logoSwu,
                      iconSize: 68,
                    ),
                    SizedBox(height: 16.0),
                    OrganizationItem(
                      nameThai: 'คุณสุพัตรา พันธุ์อำนวย',
                      nameEnglish: 'สำนักงานกองทุนสนับสนุนการสร้างเสริมสุขภาพ (สสส.)',
                      imageAsset: AssetImages.logoSSS,
                      // iconSize: 60,
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'พัฒนาโดย',
                      textAlign: TextAlign.center,
                      style: Styles.headerSection,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'นายณัฐพล ศรีโคตร',
                      textAlign: TextAlign.left,
                      style: Styles.title,
                    ),
                    Text(
                      'Embedded System & Mobile Application Laboratory',
                      style: Styles.descriptionSecondary,
                    ),
                    Text(
                      'natthaponsricort@gmail.com',
                      style: Styles.descriptionSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
