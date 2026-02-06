import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/auth_util.dart';
import 'package:meter_app/widget/text_widget.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final VoidCallback onTap;
  final Color? textColor;
  final double padding;
  final bool useGradient;   // <-- added

  const CustomButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.backgroundColor,
      this.textColor,
        this.useGradient = true,

        this.padding = 15});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              gradient: useGradient ? AuthUtil().linearGradient : null,
              color: useGradient
                  ? null
                  : (backgroundColor ?? AppColor.primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: TextWidget(
              title: title,
              fontSize: 16,
              textColor: textColor ?? Colors.white,
            )),
          ),
        ))
      ],
    );
  }
}

class MyCustomButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? borderSideColor;
  final String? iconPath;
  final double padding;
  final double fontSize;
  final bool useGradient;   // <-- added

  const MyCustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderSideColor,
    this.iconPath,
    this.padding = 15,
    this.fontSize = 16,
    this.useGradient = true,   // default false
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                gradient: useGradient ? AuthUtil().linearGradient : null,
                color: useGradient
                    ? null
                    : (backgroundColor ?? AppColor.primaryColor),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderSideColor ?? Colors.transparent,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconPath != null) ...[
                    Image.asset(iconPath!, width: 24),
                    const SizedBox(width: 10),
                  ],
                  TextWidget(
                    title: title,
                    textColor: textColor ?? AppColor.whiteColor,
                    fontSize: fontSize,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
