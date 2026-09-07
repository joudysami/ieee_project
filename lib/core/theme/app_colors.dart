import 'package:flutter/material.dart';

abstract class AppColors {
  MaterialColor get blue;
  MaterialColor get sky;
  MaterialColor get black;
  MaterialColor get grey;

  Color get error;
  Color get primary;
  Color get white;
  Color get disabledButton;
  Color get shadow;
  Color get green;

  Color get otpColor;
  Brightness get brightness;
}

class LightThemeColor implements AppColors {
  @override
  Brightness get brightness => Brightness.light;
  @override
  Color get disabledButton => Color(0xff878787);
  @override
  Color get otpColor => Color(0xFFCFCFCF);
  @override
  Color get error => Color(0xFFD32F2F);
  @override
  Color get shadow => Color(0xFFABBCDE);
  @override
  Color get primary => Color(0xFF1C4D8D);

  @override
  Color get white => Color(0xfffefefe);
  @override
  Color get green => Color(0xFF28A745);
  @override
  MaterialColor get grey => MaterialColor(0xffF9F9F9, const <int, Color>{
    50: Color(0xFFFDFDFD),
    100: Color(0xFFFDFDFD),
    200: Color(0xFFFCFCFC),
    300: Color(0xFFFBFBFB),
    400: Color(0xFFFAFAFA),
    500: Color(0xFFF9F9F9),
    600: Color(0xFFBDBDBD),
    700: Color(0xFF969696),
    800: Color(0xFF707070),
    900: Color(0xFF535353),
    950: Color(0xFF232323),
  });
  @override
  MaterialColor get black => MaterialColor(0xff0c1015, const <int, Color>{
    10: Color(0xFFcecfd0),
    20: Color(0xFFaeafb1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });
  @override
  MaterialColor get sky => MaterialColor(0xFF4988C4, <int, Color>{
    50: Color(0xFFF0F6FC),
    100: Color(0xFFD9EBF7),
    200: Color(0xFFC0DFF2),
    300: Color(0xFFA7D3ED),
    400: Color(0xFF8ACAE9),
    500: Color(0xFF4988C4),
    600: Color(0xFF4180B8),
    700: Color(0xFF3974AB),
    800: Color(0xFF2F689E),
    900: Color(0xFF1F4A7A),
  });

  @override
  MaterialColor get blue => MaterialColor(0xFF0F2854, <int, Color>{
    50: Color(0xFFE6ECEF),
    100: Color(0xFFC1D3DB),
    200: Color(0xFF9BB8C6),
    300: Color(0xFF759DB1),
    400: Color(0xFF5A8CA3),
    500: Color(0xFF0F2854),
    600: Color(0xFF0E234D),
    700: Color(0xFF0C1E44),
    800: Color(0xFF0A193D),
    900: Color(0xFF050E2A),
  });
}

class DarkThemeColor implements AppColors {
  @override
  Brightness get brightness => Brightness.dark;
  @override
  Color get disabledButton => Color(0xff878787);
  @override
  Color get otpColor => Color(0xFFCFCFCF);
  @override
  Color get error => Color(0xFFD32F2F);
  @override
  Color get shadow => Color(0xFFABBCDE);
  @override
  Color get primary => Color(0xFF1F4A7A);
  @override
  Color get white => Color(0xfffefefe);
  @override
  Color get green => Color(0xFF28A745);
  @override
  MaterialColor get grey => MaterialColor(0xffF9F9F9, const <int, Color>{
    50: Color(0xFFFDFDFD),
    100: Color(0xFFFDFDFD),
    200: Color(0xFFFCFCFC),
    300: Color(0xFFFBFBFB),
    400: Color(0xFFFAFAFA),
    500: Color(0xFFF9F9F9),
    600: Color(0xFFBDBDBD),
    700: Color(0xFF969696),
    800: Color(0xFF707070),
    900: Color(0xFF535353),
    950: Color(0xFF232323),
  });
  @override
  MaterialColor get black => MaterialColor(0xff0c1015, const <int, Color>{
    10: Color(0xFFcecfd0),
    20: Color(0xFFaeafb1),
    30: Color(0xFF86888a),
    40: Color(0xFF5d6063),
    50: Color(0xFF34383c),
    60: Color(0xFF0a0d12),
    70: Color(0xFF080b0e),
    80: Color(0xFF06080b),
    90: Color(0xFF040507),
    100: Color(0xFF020304),
  });
  @override
  MaterialColor get sky => MaterialColor(0xFF4988C4, <int, Color>{
    50: Color(0xFFF0F6FC),
    100: Color(0xFFD9EBF7),
    200: Color(0xFFC0DFF2),
    300: Color(0xFFA7D3ED),
    400: Color(0xFF8ACAE9),
    500: Color(0xFF4988C4),
    600: Color(0xFF4180B8),
    700: Color(0xFF3974AB),
    800: Color(0xFF2F689E),
    900: Color(0xFF1F4A7A),
  });

  @override
  MaterialColor get blue => MaterialColor(0xFF0F2854, <int, Color>{
    50: Color(0xFFE6ECEF),
    100: Color(0xFFC1D3DB),
    200: Color(0xFF9BB8C6),
    300: Color(0xFF759DB1),
    400: Color(0xFF5A8CA3),
    500: Color(0xFF0F2854),
    600: Color(0xFF0E234D),
    700: Color(0xFF0C1E44),
    800: Color(0xFF0A193D),
    900: Color(0xFF050E2A),
  });
}

final lightThemeColors = LightThemeColor();
final darkThemeColors = DarkThemeColor();

extension ThemeColors on BuildContext {
  AppColors get colors => Theme.of(this).brightness == Brightness.light
      ? lightThemeColors
      : darkThemeColors;
}
//  color: context.colors.error,