import 'package:flutter/material.dart';

class AppColors {
  static final grayDark = Color(0xFF333333);
  static final grayMedium = Color(0xFF4F4F4F);
  static final graySoft = Color(0xFF828282);

  static final whiteDark = Color(0xFFBDBDBD);
  static final whiteMedium = Color(0xFFE0E0E0);
  static final whiteSoft = Color(0xFFF2F2F2);

  static final blueDark = Color(0xFF0583F2);
  static final blueMedium = Color(0xFF2D9CDB);
  static final blueSoft = Color(0xFF4682B4);

  static final orangeDark = Color(0xFFF27405);
  static final orangeMedium = Color(0xFFF59137);
  static final orangeSoft = Color(0xFFF2A764);

  static final purpleDark = Color(0xFF46027B);
  static final purpleMedium = Color(0xFF9B51E0);
  static final purpleSoft = Color(0xFFBB6BD9);

  static final revenue = Color(0xFFF59137);
  static final expense = Color(0xFF79CD7D);

  static final primary = blueSoft;
  static final secondary = orangeDark;
  static final body = graySoft;
  static final delete = Color(0xFFE83F5B);
  static final background = Color(0xFFFFFFFF);

  static final primarySwatchColor = MaterialColor(
    0xFFF27405, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xFFF27405), //10%
      100: const Color(0xFFF27405), //20%
      200: const Color(0xFFF27405), //30%
      300: const Color(0xFFF27405), //40%
      400: const Color(0xFFF27405), //50%
      500: const Color(0xFFF27405), //60%
      600: const Color(0xFFF27405), //70%
      700: const Color(0xFFF27405), //80%
      800: const Color(0xFFF27405), //90%
      900: const Color(0xFFF27405), //100%
    },
  );
}
