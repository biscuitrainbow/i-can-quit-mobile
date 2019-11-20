import 'package:i_can_quit/data/model/health_regeneration.dart';

class StaticData {
  static final List<HealthRegeneration> healthRegnerations = [
    HealthRegeneration(
      title: 'การเต้นของหัวใจและความดันโลหิต',
      description: 'อัตราการเต้นของหัวใจและความดันโลหิตที่สูงขึ้นจากการสูบบุหรี่กลับสู่ระดับปกติ',
      duration: Duration(minutes: 20),
    ),
    HealthRegeneration(
      title: 'คาร์บอนมอนอกไซด์',
      description: 'คาร์บอนมอนอกไซด์ในเลือดกลับคืนสู่ภาวะปกติ',
      duration: Duration(hours: 12),
    ),
    HealthRegeneration(
      title: 'หัวใจและปอด',
      description: 'หัวใจและปอดทำหน้าที่ได้ดีขึ้น',
      duration: Duration(days: 14),
    ),
    HealthRegeneration(
      title: 'ไอและหายใจลำบาก',
      description: 'อาการไอและหายใจลำบากลดลง',
      duration: Duration(days: 30),
    ),
    HealthRegeneration(
      title: 'โรคหลอดเลือดหัวใจ',
      description: 'ความเสี่ยงในการเกิดโรคหัวใจขาดเลือดจะลดลงเหลือครึ่งหนึ่งของผู้ที่สูบบุหรี่',
      duration: Duration(days: 365),
    ),
    HealthRegeneration(
      title: 'โรคหลอดเลือดสมอง',
      description: 'ความเสี่ยงในการเกิดโรคหลอดเลือดสมองลดลง เหลือเท่า ๆ กับ กับคนที่ไม่ได้สูบบุหรี่',
      duration: Duration(days: 365 * 5),
    ),
    HealthRegeneration(
      title: 'มะเร็ง',
      description:
          'ความเสี่ยงในการเกิดโรคมะเร็งปอดลงลงเป็นครึ่งหนึ่งของผู้ที่สูบบุหรี่ และความเสี่ยงในการเกิดมะเร็งในช่องปาก ทรวงอก หลอดอาหาร กระเพาะปัสสาวะ มดลูก และ ตับอ่อนลดลง',
      duration: Duration(days: 365 * 10),
    ),
    HealthRegeneration(
      title: 'โรคหลอดเลือดหัวใจ',
      description: 'ความเสี่ยงในการเกิดโรคหลอดเลือดหัวใจลดลดเหลือเท่า ๆ กับคนไม่ได้สูบบุหรี่',
      duration: Duration(days: 365 * 15),
    )
  ];
}
