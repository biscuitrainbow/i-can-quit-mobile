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

   static const bigHeaderPrimary = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: ColorPalette.primary,
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

  static final primaryButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      stops: [0.1, 0.5, 0.7, 0.9],
      colors: [
        Colors.orange[700],
        Colors.orange[600],
        Colors.orange[500],
        Colors.orange[400],
      ],
    ),
  );

  static final secondaryDangerButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(color: Colors.red),
  );
}
