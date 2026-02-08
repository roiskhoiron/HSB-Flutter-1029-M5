import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const _primaryFont = 'Quicksand';
  static const _secondaryFont = 'Fredoka';
  static final displayLarge = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w700,
    fontSize: 57,
    height: 1.12,
    letterSpacing: -0.25,
  );
  static final displayMedium = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w700,
    fontSize: 45,
    height: 1.16,
    letterSpacing: 0,
  );
  static final displaySmall = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w700,
    fontSize: 36,
    height: 1.22,
    letterSpacing: 0,
  );

  static final headlineLarge = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.25,
    letterSpacing: 0,
  );
  static final headlineMedium = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 28,
    height: 1.29,
    letterSpacing: 0,
  );
  static final headlineSmall = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.33,
    letterSpacing: 0,
  );

  static final titleLarge = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 22,
    height: 1.27,
    letterSpacing: 0,
  );
  static final titleMedium = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.15,
  );
  static final titleSmall = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
  );

  static final bodyLarge = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0.5,
  );
  static final bodyMedium = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.25,
  );
  static final bodySmall = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  );

  static final labelLarge = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0.1,
  );
  static final labelMedium = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.5,
  );
  static final labelSmall = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 1.27,
    letterSpacing: 0.5,
  );

  static final buttonText = _buildTextStyle(
    fontFamily: _primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.25,
    letterSpacing: 0.5,
  );
  static final caption = _buildTextStyle(
    fontFamily: _secondaryFont,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
  );
  static final overline = _buildTextStyle(
    fontFamily: _secondaryFont,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.6,
    letterSpacing: 1.5,
  );

  static TextStyle _buildTextStyle({
    required String fontFamily,
    required FontWeight fontWeight,
    required double fontSize,
    required double height,
    required double letterSpacing,
  }) => GoogleFonts.getFont(
    fontFamily,
    fontWeight: fontWeight,
    fontSize: fontSize,
    height: height,
    letterSpacing: letterSpacing,
  );

  static TextTheme lightTextTheme() => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );

  static TextTheme darkTextTheme() => lightTextTheme();
}

extension TypographyExtension on BuildContext {
  TextStyle get displayLarge => AppTypography.displayLarge;
  TextStyle get displayMedium => AppTypography.displayMedium;
  TextStyle get displaySmall => AppTypography.displaySmall;
  TextStyle get headlineLarge => AppTypography.headlineLarge;
  TextStyle get headlineMedium => AppTypography.headlineMedium;
  TextStyle get headlineSmall => AppTypography.headlineSmall;
  TextStyle get titleLarge => AppTypography.titleLarge;
  TextStyle get titleMedium => AppTypography.titleMedium;
  TextStyle get titleSmall => AppTypography.titleSmall;
  TextStyle get bodyLarge => AppTypography.bodyLarge;
  TextStyle get bodyMedium => AppTypography.bodyMedium;
  TextStyle get bodySmall => AppTypography.bodySmall;
  TextStyle get labelLarge => AppTypography.labelLarge;
  TextStyle get labelMedium => AppTypography.labelMedium;
  TextStyle get labelSmall => AppTypography.labelSmall;
  TextStyle get buttonText => AppTypography.buttonText;
  TextStyle get caption => AppTypography.caption;
  TextStyle get overline => AppTypography.overline;

  TextTheme get textTheme => Theme.of(this).textTheme;
}
