import 'package:flutter/widgets.dart';

// abstract class ColorsManager {
//   static const Color darkBlueViolet = Color(0xFF1C1B2E);
//   static const Color lightPurple = Color(0xFF231F41);
//   static const Color lightShade = Color(0xFF201D3C);
//   static const Color darkBlue = Color(0xFF131519);
//   static const Color buttonColor = Color(0xFF6855FF);
// }
import 'package:flutter/material.dart';

abstract class ColorsManager {
  //gradiants
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightShade, darkBlueViolet, lightPurple],
  );
  static const LinearGradient cardGradientV = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightShade, darkBlueViolet],
  );
  static const LinearGradient subtleGradient = LinearGradient(
    colors: [lightPurple, darkBlueViolet],
    stops: [0.2, 0.8],
  );
  static const LinearGradient lightCardGradient = LinearGradient(
    colors: [Color(0xFFE0E0FF), Color(0xFFF5F5FF)],
  );
  static LinearGradient get imagePrimaryGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      darkBlueViolet.withOpacity(0.7),
      darkBlueViolet.withOpacity(0.9),
    ],
  );

  static LinearGradient get imageLightGradient => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xFFA0A0CC).withOpacity(0.5),
      Color(0xFF8080B0).withOpacity(0.8),
    ],
  );

  // Core
  static const Color darkBlueViolet = Color(0xFF1C1B2E);
  static const Color lightPurple = Color(0xFF231F41);
  static const Color lightShade = Color(0xFF201D3C);
  static const Color darkBlue = Color(0xFF131519);
  static const Color buttonColor = Color(0xFF6855FF);

  // Cards
  static const Color cardBackgroundDark = Color(0xFF2A2746);
  static const Color cardBackgroundLight = Color(0xFFF5F5FF);
  static const Color borderDark = Color(0xFF3D3A5C);
  static const Color borderLight = Color(0xFFC1C1E8);
  static const Color borderAccent = Color(0xFF6855FF);
  static const Color cardDark = Color(0xFF1E1E2C);

  // Text
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA0A0CC);
  static const Color textPrimaryLight = darkBlueViolet;
  static const Color textSecondaryLight = Color(0xFF5E5E7A);

  // Accents
  static const Color accentLight = Color(0xFF8577FF);
  static const Color accentDark = Color(0xFF4D3DFF);
}