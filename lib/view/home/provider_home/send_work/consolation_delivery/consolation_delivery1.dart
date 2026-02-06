import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:meter_app/controller/bottom_nav_controller/provider_controller/send_work/consolation_delivery_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

import '../../../../services/publish_device/publish_device1.dart';

class ConsolationFirstDelivery extends StatelessWidget {
  const ConsolationFirstDelivery({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConsolationDeliveryController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        bottomNavigationBar: Container(
            height: Get.height * 0.12,
            margin:
                EdgeInsets.only(bottom: Get.height * 0.02, left: 14, right: 14),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyCustomButton(
                      onTap: () {},
                      title: "Print",
                      backgroundColor: Colors.transparent,
                      borderSideColor: AppColor.primaryColor,
                      textColor: AppColor.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.03,
                  ),
                  Expanded(
                    child: MyCustomButton(
                      onTap: () async {
                        Get.bottomSheet(CustomSuccessScreen(
                          title: "work has been sent",
                          height: 0.60,
                          buttonTitle: "Done",
                          desc: "Congratulations! Your work has been sent",
                          newWidget: Lottie.asset(AppImage.workDone),
                          onDoneTap: () {
                            //Change to original
                            Get.back();
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        ));
                      },
                      title: "Send Work".tr,
                    ),
                  ),
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomHeader(
                title: "Consolation Delivery",
                showProgress: true,
                progressWidth: 1,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    ImagePickContainer(
                        title: "Click to upload\nWork copy here"),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter office name",
                        title: "Electronic signature",
                        controller: controller.electronicSignatureController),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Obx(() => checkBoxWithTitle(
                          controller.isAccurateInfoChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title: "Commitment to pay Meter application dues",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) => controller.toggleAccurateInfo(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isPayDuesChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) => controller.togglePayDues(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isAgreeTermsChecked.value,
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.dark14,
                              children: [
                                TextSpan(text: 'Agree to the '.tr),
                                TextSpan(
                                  text: 'privacy policy & terms'.tr,
                                  style: AppTextStyle.dark14
                                      .copyWith(color: AppColor.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      log('Navigate to terms & conditions');
                                    },
                                ),
                                TextSpan(text: ' ${"of service"}'.tr),
                              ],
                            ),
                          ),
                          (newValue) => controller.toggleAgreeTerms(newValue),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
