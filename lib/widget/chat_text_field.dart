import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';

class ChatTextField extends StatelessWidget {
  final String hintText;

  const ChatTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColor.whiteShade, borderRadius: BorderRadius.circular(12)),
      child: TextField(
        maxLines: 2,
        cursorColor: AppColor.primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyle.dark14,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
