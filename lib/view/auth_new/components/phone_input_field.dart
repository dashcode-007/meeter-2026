import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:sizer/sizer.dart';

class PhoneInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;

  const PhoneInputField({
    super.key,
    this.label = 'Phone No',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColor.hintTxt,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 6.5.h,
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
          child: Row(
            children: [
              SizedBox(width: 5.w),
              Container(
                width: 30,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color(0xFF0F6B3E),
                ),
                child: const Center(
                  child: Text(
                    '🇸🇦',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              const Text(
                '+966',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFF9147),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: AppFonts.artegraSoft,
                    height: 1.0,
                    color: AppColor.hintTxt,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '',
                    contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
        ),
      ],
    );
  }
}
