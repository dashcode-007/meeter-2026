import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/language_utils.dart';

class CustomBackButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.backgroundColor, this.onTap});
  @override
  Widget build(BuildContext context) {
    bool isEnglish = LanguageUtils.isEnglishLang();
    return GestureDetector(
      onTap: onTap ??
          () {
            Get.back();
          },
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            shape: BoxShape.circle,
            border:
                Border.all(color: AppColor.semiTransparentDarkGrey, width: 1)),
        child: Center(
            child: Image.asset(
          AppImage.back,
          width: 24,
        )),
      ),
    );
  }
}
