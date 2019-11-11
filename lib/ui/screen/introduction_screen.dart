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
            "มีการศึกษาวิจัยมากมายที่แสดงให้เห็นถึงความสัมพันธ์ระหว่างการสูบบุหรี่กับการเกิดโรคต่างๆ ผู้สูบบุหรี่แต่ละรายจะมีโอกาสเสี่ยงในการเกิดโรคจากบุหรี่แตกต่างกัน",
        pathImage: "assets/images/lung.png",
        backgroundColor: Colors.white,
        styleTitle: Styles.bigHeaderPrimary,
        styleDescription: Styles.descriptionSecondary,
      ),
    );
    slides.add(
      new Slide(
        title: "สารประกอบ",
        description: "โทษจากบุหรี่เกิดจากสารประกอบในควันบุหรี่ ควันบุหรี่จะมีสารประกอบต่างๆ มากกว่า 4,000 ชนิด",
        pathImage: "assets/images/smoke.png",
        backgroundColor: Colors.white,
        styleTitle: Styles.bigHeaderPrimary,
        styleDescription: Styles.descriptionSecondary,
      ),
    );
    slides.add(
      new Slide(
        title: "ผลต่อการตั้งครรภ์",
        description:
            "การสูบบุหรี่ทำให้โอกาสที่จะตั้งครรภ์ยากขึ้น ผู้หญิงที่ตั้งครรภ์และสูบบุหรี่จะทำให้ทารกมีน้ำหนักแรกคลอดน้อยกว่าทารกปกติประมาณ 170 กรัม",
        pathImage: "assets/images/pregnancy.png",
        backgroundColor: Colors.white,
        styleTitle: Styles.bigHeaderPrimary,
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
      styleNameSkipBtn: Styles.titlePrimary.copyWith(fontSize: 16),
      styleNameDoneBtn: Styles.titlePrimary.copyWith(fontSize: 16),
    );
  }
}
