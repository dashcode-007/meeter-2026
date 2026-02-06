import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:sizer/sizer.dart';

class MultilineInputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final int maxLines;

  const MultilineInputField({
    super.key,
    required this.hint,
    this.controller,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          fontFamily: AppFonts.artegraSoft,
          height: 1.0,
          color: AppColor.hintTxt,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: AppFonts.artegraSoft,
            height: 1.0,
            color: AppColor.surveycreenTxt,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.8.h),
        ),
      ),
    );
  }
}
