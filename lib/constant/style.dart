import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';

abstract class Styles {
  static const titlePrimary = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: ColorPalette.primary,
  );

  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Color(0xFF1F2933),
  );

  static const biggerHeader = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const bigHeader = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  static const description = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Color(0xFFFFFFFF),
  );

  static const descriptionSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: Color(0XFF9E9E9E),
  );
}
