import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/routes/routes_name.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/text_widget.dart';

class FaceScaning extends StatelessWidget {
  const FaceScaning({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin:
                EdgeInsets.only(bottom: Get.height * 0.05, left: 14, right: 14),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: MyCustomButton(
                title: "Log In With Phone Number".tr,
                onTap: () {
                  Get.offAllNamed(RoutesName.mainAuthScreen);
                },
                textColor: AppColor.primaryColor,
                backgroundColor: AppColor.primaryShade,
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextWidget(
                  title: "Face ID Security",
                  fontSize: 16,
                  textColor: AppColor.semiDarkGrey,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                TextWidget(
                  title: "Log In your account with your face using face id",
                  textColor: AppColor.semiDarkGrey,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Image.asset(AppImage.processingFace),
                SizedBox(
                  height: Get.height * 0.06,
                ),
                TextWidget(
                  title:
                      "Please position your face in front of the camera to authenticate with face id",
                  textColor: AppColor.semiDarkGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
