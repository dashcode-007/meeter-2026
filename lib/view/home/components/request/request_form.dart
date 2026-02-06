import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/bottom_nav_controller_main.dart';
import 'package:meter_app/controller/bottom_nav_controller/provider_controller/request_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/group_radio_button.dart';
import 'package:meter_app/widget/linear_progress.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';
import '../../../../../utils/app_textstyle.dart';
import '../../../services/publish_device/publish_device1.dart';

class RequestForm extends StatelessWidget {
  final bool showPicture;
  const RequestForm({super.key, this.showPicture = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestFormController());
    return SafeArea(
      child: Container(
        height: Get.height * 0.87,
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                CustomLinearProgress(
                  value: showPicture ? 0.3 : 1,
                  backgroundColor: AppColor.primaryColorShade1,
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                if (showPicture) ...[
                  CustomTextField(
                      hintText: "Enter title",
                      title: "Title",
                      controller: controller.titleController)
                ],
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.priceController,
                        hintText: "Enter Price",
                        title: "Price",
                        textInputType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.taxController,
                        prefixImagePath: AppImage.percent,
                        hintText: "Enter Tax",
                        title: "Tax",
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const TextWidget(
                    title: "Fees",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  children: [
                    Obx(() => rowWithRadio(
                          'Consolation',
                          controller.selectedOption.value,
                          'Consolation',
                          (newValue) => controller.selectOption(newValue!),
                        )),
                    Obx(() => rowWithRadio(
                          'Request Pricing',
                          controller.selectedOption.value,
                          'Request Pricing',
                          (newValue) => controller.selectOption(newValue!),
                        )),
                  ],
                ),
                CustomTextField(
                  controller: controller.totalController,
                  textInputType: TextInputType.number,
                  hintText: "100.50",
                  title: "Total",
                  hintTextColor: AppColor.primaryColor,
                ),
                CustomTextField(
                  controller: controller.detailsController,
                  hintText: "Write Details",
                  title: "Details",
                  maxLine: 5,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                // if (showPicture)
                //   Obx(
                //     () => checkBoxWithTitle(
                //       controller.isAgreeTermsChecked.value,
                //       RichText(
                //         text: TextSpan(
                //           style: AppTextStyle.dark14,
                //           children: [
                //             TextSpan(text: 'I agree to the '.tr),
                //             TextSpan(
                //               text: 'terms & conditions'.tr,
                //               style: AppTextStyle.dark14
                //                   .copyWith(color: AppColor.primaryColor),
                //               recognizer: TapGestureRecognizer()
                //                 ..onTap = () {
                //                   // Navigate to terms & conditions page or handle click event
                //                   print('Navigate to terms & conditions');
                //                 },
                //             ),
                //             TextSpan(text: ' by creating account.'.tr),
                //           ],
                //         ),
                //       ),
                //       (newValue) => controller.toggleAgreeTerms(newValue),
                //     ),
                //   ),
                // SizedBox(
                //   height: Get.height * 0.03,
                // ),
                CustomButton(
                    title: showPicture ? "Continue" : "Send",
                    onTap: () {
                      if (showPicture) {
                        Get.back();
                        Get.bottomSheet(const ClickToUploadDevice(),
                            isScrollControlled: true);
                      } else {
                        Get.back();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClickToUploadDevice extends StatelessWidget {
  const ClickToUploadDevice({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestFormController());
    return Container(
      height: Get.height * 0.5,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.04,
          ),
          const CustomLinearProgress(
            value: 1,
            backgroundColor: AppColor.primaryColorShade1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                const ImagePickContainer(title: "Click to upload"),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(
                  () => checkBoxWithTitle(
                    controller.isAgreeTermsChecked.value,
                    RichText(
                      text: TextSpan(
                        style: AppTextStyle.dark14,
                        children: [
                          TextSpan(text: 'I agree to the '.tr),
                          TextSpan(
                            text: 'terms & conditions'.tr,
                            style: AppTextStyle.dark14
                                .copyWith(color: AppColor.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to terms & conditions page or handle click event
                                print('Navigate to terms & conditions');
                              },
                          ),
                          TextSpan(text: ' by creating account.'.tr),
                        ],
                      ),
                    ),
                    (newValue) => controller.toggleAgreeTerms(newValue),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CustomButton(
                    title: "Apply",
                    onTap: () {
                      Get.back();
                      Get.bottomSheet(
                        CustomSuccessScreen(
                            onDoneTap: () {
                              Get.back();
                              Get.find<BottomNavController>()
                                  .currentIndex
                                  .value = 2;
                              // Get.offAll(const BottomNavMain());
                            },
                            title: "Applied Proposal",
                            buttonTitle: "Done",
                            desc:
                                "Your proposal has been applied. wait approvment from customer,"),
                      );
                      // Get.dialog(
                      //     CustomSuccessScreen(
                      //         onDoneTap: () {
                      //           Get.offAll(const BottomNavMain());
                      //         },
                      //         title: "Applied Proposal",
                      //         buttonTitle: "Done",
                      //         desc:
                      //         "Your proposal has been applied. wait approvment from customer,"),
                      //     barrierDismissible: false);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
