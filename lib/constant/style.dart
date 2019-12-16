import 'package:flutter/material.dart';
import 'package:i_can_quit/constant/color-palette.dart';

abstract class Styles {
  static final headerSection = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade800,
  );

  static final headerSectionPrimary = headerSection.copyWith(
    color: ColorPalette.primary,
  );

  static final header = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade800,
  );

  static final headerAccent = header.copyWith(
    color: Colors.white,
  );

  static final headerPrimary = headerAccent.copyWith(
    color: ColorPalette.primary,
  );

  static final headerBigger = headerAccent.copyWith(
    fontSize: 42,
  );

  static final title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade800,
  );

  static final titleAccent = title.copyWith(
    color: Colors.white,
  );

  static final titleSecondary = title.copyWith(
    color: ColorPalette.secondary,
  );

  static final description = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w200,
    color: Colors.grey.shade800,
  );

  static final descriptionAccent = description.copyWith(
    color: Colors.white,
  );

  static final descriptionSecondary = description.copyWith(
    color: ColorPalette.secondary,
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
