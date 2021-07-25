import 'package:finhelper/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final titleSplash = GoogleFonts.offside(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.grayDark,
  );

  static final textSplash = GoogleFonts.offside(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.grayDark,
  );

  static final titleGraySoftRegular = GoogleFonts.roboto(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.graySoft,
  );

  static final titleWhiteBold = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteSoft,
  );

  static final subTitleWhiteSoft = GoogleFonts.roboto(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteSoft,
  );

  static final titleBlack = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final subTitleBlack = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static final titleMovementWhite = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteSoft,
  );

  static final subTitleMovementWhite = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.whiteSoft,
  );
}
