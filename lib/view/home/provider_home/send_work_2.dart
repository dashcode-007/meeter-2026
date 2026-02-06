import 'dart:developer';
import 'package:lottie/lottie.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/provider_controller/send_work/send_work_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/send_work_bottom_sheet/boundaries_custom_widget.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

import '../../services/publish_device/publish_device1.dart';

class SendSecondWork extends StatelessWidget {
  const SendSecondWork({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SendWorkController>();
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
                        Get.bottomSheet(
                            isScrollControlled: true,
                            CustomSuccessScreen(
                              title: "work has been sent",
                              height: 0.64,
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
              const CustomHeader(
                title: "Send work",
                showProgress: true,
                progressWidth: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    MyCustomButton(
                        title: "Enter the property properties",
                        backgroundColor: Colors.transparent,
                        borderSideColor: AppColor.primaryColor,
                        textColor: AppColor.primaryColor,
                        onTap: () {
                          Get.bottomSheet(
                            BoundariesCustomWidget(
                              header: "North Direction",
                              progressValue: 0.20,
                              boundariesByNatureController:
                                  controller.northBoundariesByNatureController,
                              boundariesByNatureHeightController: controller
                                  .northBoundariesByNatureHeightController,
                              boundariesByDeedController:
                                  controller.northBoundaryByDeadController,
                              boundariesByDeedHeightController: controller
                                  .northBoundaryByDeadHeightController,
                              boundariesByPlanController:
                                  controller.northBoundariesByPlanController,
                              boundariesByPlanHeightController: controller
                                  .northBoundaryByPlanHeightController,
                              onTap: () {
                                Get.back();
                                Get.bottomSheet(
                                  BoundariesCustomWidget(
                                    header: "East Direction",
                                    progressValue: 0.40,
                                    boundariesByNatureController: controller
                                        .eastBoundariesByNatureController,
                                    boundariesByNatureHeightController: controller
                                        .eastBoundariesByNatureHeightController,
                                    boundariesByDeedController:
                                        controller.eastBoundaryByDeadController,
                                    boundariesByDeedHeightController: controller
                                        .eastBoundaryByDeadHeightController,
                                    boundariesByPlanController: controller
                                        .eastBoundariesByPlanController,
                                    boundariesByPlanHeightController: controller
                                        .eastBoundaryByPlanHeightController,
                                    onTap: () {
                                      Get.back();
                                      Get.bottomSheet(
                                        BoundariesCustomWidget(
                                          header: "South Direction",
                                          progressValue: 0.60,
                                          boundariesByNatureController: controller
                                              .southBoundariesByNatureController,
                                          boundariesByNatureHeightController:
                                              controller
                                                  .southBoundariesByNatureHeightController,
                                          boundariesByDeedController: controller
                                              .southBoundaryByDeadController,
                                          boundariesByDeedHeightController:
                                              controller
                                                  .southBoundaryByDeadHeightController,
                                          boundariesByPlanController: controller
                                              .southBoundariesByPlanController,
                                          boundariesByPlanHeightController:
                                              controller
                                                  .southBoundaryByPlanHeightController,
                                          onTap: () {
                                            Get.back();
                                            Get.bottomSheet(
                                              BoundariesCustomWidget(
                                                header: "West Direction",
                                                progressValue: 0.80,
                                                buttonText: "Done",
                                                boundariesByNatureController:
                                                    controller
                                                        .westBoundariesByNatureController,
                                                boundariesByNatureHeightController:
                                                    controller
                                                        .westBoundariesByNatureHeightController,
                                                boundariesByDeedController:
                                                    controller
                                                        .westBoundaryByDeadController,
                                                boundariesByDeedHeightController:
                                                    controller
                                                        .westBoundaryByDeadHeightController,
                                                boundariesByPlanController:
                                                    controller
                                                        .westBoundariesByPlanController,
                                                boundariesByPlanHeightController:
                                                    controller
                                                        .westBoundaryByPlanHeightController,
                                                onTap: () {
                                                  Get.back();
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.06,
                    ),
                    const ImagePickContainer(
                        title: "Click to Upload\n Work from Autocad"),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    CustomTextField(
                        hintText: "Enter office name",
                        title: "Electronic Signature",
                        controller: controller.electronicSignatureController),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Obx(() => checkBoxWithTitle(
                          controller.isAccurateInfoChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title: "Commitment to pay Meter application dues",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) =>
                              controller.toggleSellerAccurateInfo(newValue),
                        )),
                    Obx(() => checkBoxWithTitle(
                          controller.isPayDuesChecked.value,
                          const TextWidget(
                              textAlign: TextAlign.start,
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14),
                          (newValue) =>
                              controller.toggleSellerPayDues(newValue),
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
                                TextSpan(text: 'of service'.tr),
                              ],
                            ),
                          ),
                          (newValue) =>
                              controller.toggleSellerAgreeTerms(newValue),
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
