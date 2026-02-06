import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/widget/containers/back_button.dart';
import 'package:meter_app/widget/text_widget.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool showProgress;
  final double progressWidth;
  final bool showLoadingPadding;
  final VoidCallback? onTap;
  const CustomHeader(
      {super.key,
      required this.title,
      this.showProgress = false,
      this.progressWidth = 3,
      this.showLoadingPadding = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 14.0, right: 5, top: 14, bottom: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomBackButton(
                onTap:
                    () {
                      Get.back();
                    },
              ),
              const Spacer(),
              SizedBox(
                width: Get.width * 0.60,
                child: TextWidget(
                  title: title,
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Container(),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        showProgress
            ? Align(
                alignment: Alignment.topLeft,
                child: Container(
                  color: AppColor.primaryColor,
                  height: 4,
                  width: Get.width / progressWidth,
                ),
              )
            : Container(),
      ],
    );
  }
}
