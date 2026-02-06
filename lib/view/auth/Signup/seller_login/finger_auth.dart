import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/finger_recognize_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
import 'package:meter_app/view/bottom_nav/home/home_screen.dart';
import 'package:meter_app/view/bottom_nav/home/seller_home/seller_home_main.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';

class SellerFingerAuth extends StatelessWidget {
  final String? userType;

  final FingerAuthController _authController = Get.put(FingerAuthController());

    SellerFingerAuth({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(() => Container(
            height: Get.height * 0.12,
            margin:
                EdgeInsets.only(bottom: Get.height * 0.02, left: 14, right: 14),
            child: _authController.isContinueLoading.value
                ? const CustomLoading()
                : Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyCustomButton(
                            onTap: () {
                              // Get.bottomSheet(
                              //   CustomSuccessScreen(
                              //     title: "Created Account",
                              //     onDoneTap: () async {
                              //       Get.offAll(const SellerHomeMain());
                              //     },
                              //     desc: "Congratulations! Your account has been created. Click continue to start"
                              //             .tr,
                              //     buttonTitle: "Done".tr,
                              //   ),
                              // );
                              Get.offAll(  MainHomeScreen(userType: userType ,));
                              log("type is ${userType!}");
                            },
                            title: "Skip",
                            useGradient: false,
                            backgroundColor: AppColor.lightBlueShade,
                            textColor: AppColor.primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: MyCustomButton(
                            onTap: () async {
                              Get.bottomSheet(
                                CustomSuccessScreen(
                                  title: "Created Account",
                                  onDoneTap: () async {
                                    // await _authController.onContinueClick();
                                    Get.offAll(  MainHomeScreen(userType: userType ,));
                                    log("type is ${userType!}");

                                  },
                                  desc: "Congratulations! Your account has been created. Click continue to start"
                                          .tr,
                                  buttonTitle: "Done".tr,
                                ),
                              );
                            },
                            title: "Continue".tr,
                          ),
                        ),
                      ],
                    ),
                  ))),
        backgroundColor: AppColor.whiteColor,
        body: Obx(() => Column(
              children: [
                CustomHeader(title: "Touch ID Security".tr),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: TextWidget(
                      title:
                          "Secure your account with your fingerprint using Touch ID",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 14),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                if (_authController.isFingerprintAvailable.value)
                  _authController.isLoading.value
                      ? const CustomLoading()
                      : _authController.isAuthenticated.value
                          ? Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                      AppImage.authenticatedFinger)),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: GestureDetector(
                                  onTap: () {
                                    _authController.authenticate();
                                  },
                                  child:
                                      Image.asset(AppImage.proccessingFinger)),
                            ),
                if (!_authController.isFingerprintAvailable.value)
                  const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: TextWidget(
                      title: "Fingerprint sensor not available",
                      textColor: AppColor.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: TextWidget(
                      title:
                          "Please place your finger on the fingerprint sensor to get started",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 14),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                if (_authController.isLoading.value)
                  const CustomLoading(), // Show loading indicator
                if (_authController.isAuthenticated.value)
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImage.check),
                        const SizedBox(
                          width: 10,
                        ),
                        const TextWidget(
                            title: "Authentication successful",
                            textColor: AppColor.successColor,
                            fontSize: 14)
                      ],
                    ),
                  ),
              ],
            )),
      ),
    );
  }
}
