import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meter_app/res/app_color/app_color.dart';

class AppTextStyle {
  static TextStyle dark14 = GoogleFonts.poppins(
    color: AppColor.semiTransparentDarkGrey,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  static TextStyle dark20 = GoogleFonts.poppins(
    color: AppColor.semiDarkGrey,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
  );
}
