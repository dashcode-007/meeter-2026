import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../res/app_fonts/app_fonts.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({
    super.key,
    required this.title,
    this.onPressed,
    this.height = 45,
    this.horizontalPadding,
    this.backgroundColor = const Color(0xffEFA66F),
    this.borderRadius = 15,
    this.textSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  final String title;
  final VoidCallback? onPressed;
  final double height;
  final double? horizontalPadding;
  final Color backgroundColor;
  final double borderRadius;
  final double textSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 5.w),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: fontWeight,
              fontFamily: AppFonts.artegraSoft,
            ),
          ),
        ),
      ),
    );
  }
}
