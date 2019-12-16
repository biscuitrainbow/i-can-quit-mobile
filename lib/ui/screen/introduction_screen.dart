import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/style.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroductionScreen extends StatefulWidget {
  static final String route = '/introduction';

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "โรคจากบุหรี่",
        description:
            "บุหรี่เป็นสาเหตุที่ทำให้เกิดโรคต่าง ๆ ได้มากมาย ผู้ที่สูบบุหรี่อย่างต่อเนื่องจะมีอัตราการเสียชีวิตเพิ่มขึ้นเป็น 3 เท่าของผู้ที่ไม่สูบบุหรี่",
        pathImage: "assets/images/lung.png",
        backgroundColor: Colors.white,
        styleTitle: Styles.headerPrimary,
        styleDescription: Styles.descriptionSecondary,
      ),
    );
    slides.add(
      new Slide(
        title: "สารประกอบ",
        description:
            "บุหรี่ อันตรายกว่าที่คิดบุหรี่มีสารมากกว่า 7,000 ชนิดที่เกิดจากการเผาไหม้บุหรี่ ในจำนวนนั้นสารหลายร้อยชนิดมีผลต่อการทำงานของร่างกาย และมากกว่า 70 ชนิดที่เป็นสารก่อมะเร็ง",
        pathImage: "assets/images/smoke.png",
        backgroundColor: Colors.white,
        styleTitle: Styles.headerPrimary,
        styleDescription: Styles.descriptionSecondary,
      ),
    );
    slides.add(
      new Slide(
        title: "ควันบุหรี่มือสาม \nภัยร้ายที่มองไม่เห็น",
        description:
            "สารพิษจากควันบุหรี่ที่ตกค้างตามเส้นผม ผิวหนัง เสื้อผ้า พรม ผ้าม่าน ตุ๊กตา โซฟา ที่นอน ฯลฯ เป็นแหล่งของควันบุหรี่มือสาม มีสารพิษตกค้างที่ก่อให้เกิดมะเร็ง",
        pathImage: "assets/images/pregnancy.png",
        backgroundColor: Colors.white,
        styleTitle: Styles.headerPrimary,
        styleDescription: Styles.descriptionSecondary,
      ),
    );
  }

  void onDonePress() {
    Navigator.of(context).pop();
  }

  void onSkipPress() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
      styleNameSkipBtn: Styles.headerSectionPrimary.copyWith(fontSize: 16),
      styleNameDoneBtn: Styles.headerSectionPrimary.copyWith(fontSize: 16),
    );
  }
}
