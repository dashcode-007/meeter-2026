import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/text_widget.dart';

class CustomSuccessScreen extends StatelessWidget {
  final String title;
  final VoidCallback? onDoneTap;
  final String? desc;
  final double height;
  final String buttonTitle;
  final Widget? newWidget;
  const CustomSuccessScreen(
      {super.key,
      required this.title,
      this.onDoneTap,
      this.desc,
      this.height = 0.50,
      required this.buttonTitle,
      this.newWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * height,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height * height, // Set the maximum height here
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                newWidget ?? Image.asset(AppImage.security),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextWidget(
                  title: title,
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const TextWidget(
                    title: "Successfully🎉",
                    fontWeight: FontWeight.bold,
                    textColor: AppColor.primaryColor,
                    fontSize: 20),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextWidget(
                    title: desc ?? "",
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 13),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                MyCustomButton(title: buttonTitle, onTap: onDoneTap!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutDialogue extends StatelessWidget {
  final String title;
  final double height;
  final String description;
  final String mainButtonText;
  final VoidCallback mainButtonTap;
  const LogoutDialogue(
      {super.key,
      required this.title,
      required this.description,
      required this.mainButtonText,
      required this.mainButtonTap,
      this.height = 0.40});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: Get.height * height, // Set the maximum height here
              maxWidth: Get.width),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          AppImage.cancel,
                          width: 45,
                        )),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  TextWidget(
                    title: title,
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextWidget(
                    title: description,
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyCustomButton(
                          title: "Cancel",
                          textColor: AppColor.semiTransparentDarkGrey,
                          backgroundColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyCustomButton(
                            backgroundColor: AppColor.primaryColorShade1,
                            title: mainButtonText,
                            onTap: mainButtonTap),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
