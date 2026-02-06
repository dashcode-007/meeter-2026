import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/view/face_scaning.dart';
import 'package:meter_app/view/on_board/on_board_detail.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/rich_text.dart';
import 'package:meter_app/widget/text_widget.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: Get.width,
                height: Get.height * 0.6,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImage.onBoard),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: Get.height * 0.37,
                width: Get.width,
                padding: const EdgeInsets.all(15.0),
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Image.asset(
                      AppImage.threedot,
                      width: Get.width * 0.25,
                    ),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    CustomRichText(
                        firstSize: 30,
                        secondSize: 30,
                        firstText: "Welcome To ",
                        secondText: "Meter",
                        press: () {}),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const TextWidget(
                        fontSize: 14,
                        title:
                            "Your Trusted Partner in Engineering and Surveying Solutions"),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    CustomButton(
                        title: "Continue",
                        onTap: () {
                          // Get.offAll(const OnBoardDetail());
                          // Get.offAll(const FaceScaning());
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
