import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lomba_frontend/core/double_extention.dart';

class SharmiaTextStyles extends TextStyle {
  const SharmiaTextStyles(
      {double? fontSize,
      FontStyle? fontStyle,
      FontWeight? fontWeight,
      Color? color,
      double? height})
      : super(
            fontSize: fontSize,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            color: color,
            height: height);

  static TextStyle textPageTitle(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 14,
        fontStyle: FontStyle.normal,
        height: 17.0.toFigmaHeight(14),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle textRegular(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        height: 24.0.toFigmaHeight(16),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle textSubtitle(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 12,
        fontStyle: FontStyle.normal,
        height: 14.0.toFigmaHeight(12),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle textButtonLabel(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        height: 19.0.toFigmaHeight(16),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle textPostTitle(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 24,
        fontStyle: FontStyle.normal,
        height: 29.0.toFigmaHeight(24),
        fontWeight: FontWeight.w800,
        color: color,
      );

  static TextStyle textPostTexts(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 18,
        fontStyle: FontStyle.normal,
        height: 25.0.toFigmaHeight(18),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle textPlaceholderText(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        height: 19.0.toFigmaHeight(16),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle textPlaceholder(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        height: 19.0.toFigmaHeight(16),
        fontWeight: FontWeight.w400,
        color: color,
      );
  static TextStyle textButtonNumber(Color color) => TextStyle(
        fontFamily: 'Arial',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        height: 18.0.toFigmaHeight(16),
        fontWeight: FontWeight.w400,
        color: color,
      );
  static TextStyle textLinks(Color color) => GoogleFonts.getFont(
        'Lato',
        fontSize: 14,
        fontStyle: FontStyle.normal,
        height: 17.0.toFigmaHeight(14),
        fontWeight: FontWeight.w400,
        color: color,
        decoration: TextDecoration.underline,
      );
}
