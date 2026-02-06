import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/account_controller/profile_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/widget/text_widget.dart';

class CustomRow extends StatelessWidget {
  final String? firstImagePath;
  final String title;
  final VoidCallback onTap;
  final String? selectedLanguage;
  final List<dynamic>? dropDownItems;
  final Function(dynamic)? onLanguageChanged;
  final Color? textColor;
  const CustomRow(
      {super.key,
      this.firstImagePath,
      required this.title,
      required this.onTap,
      this.dropDownItems,
      this.onLanguageChanged,
      this.selectedLanguage,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            child: Row(
              children: [
                firstImagePath != null
                    ? Image.asset(
                        firstImagePath!,
                        width: 18,
                      )
                    : Container(),
                firstImagePath != null
                    ? const SizedBox(
                        width: 10,
                      )
                    : Container(),
                TextWidget(
                    title: title,
                    textColor: textColor ?? AppColor.semiDarkGrey,
                    fontSize: 16),
                const Spacer(),
                dropDownItems == null
                    ? Obx(() => Image.asset(
                          controller.leftIcon.value
                              ? AppImage.leftSide
                              : AppImage.rightIcon,
                          width: 18,
                        ))
                    : Container(
                        height: Get.height * 0.04,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.semiTransparentDarkGrey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: DropdownButton<dynamic>(
                          value: selectedLanguage,
                          onChanged: onLanguageChanged,
                          items: dropDownItems!
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: TextWidget(
                                title: value,
                                textColor: AppColor.semiDarkGrey,
                                fontSize: 14,
                              ),
                            );
                          }).toList(),
                          underline:
                              SizedBox.shrink(), // Remove the default underline
                        ),
                      ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }
}
