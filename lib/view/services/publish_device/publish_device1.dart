import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/model/seller/device/device_model.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/linear_progress.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

import '../../../../../controller/bottom_nav_controller/seller_controller/publish_device_controller.dart';

class PublishFirstDevice extends StatelessWidget {
  const PublishFirstDevice({super.key});

  @override
  Widget build(BuildContext context) {
    final PublishDeviceController publishDeviceController =
        Get.find<PublishDeviceController>();
    final arguments = Get.arguments as Map<String, dynamic>;
    bool isUpdate = arguments["isUpdate"];
    DeviceModel? deviceModel;
    if (arguments["deviceModel"] != null) {
      deviceModel = arguments["deviceModel"];
    }
    log("Is Update $isUpdate");
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                      offset: const Offset(-16, 2),
                      child: CustomHeader(
                          title: !isUpdate
                              ? "Publish a device".tr
                              : "Edit a device")),
                  Transform.translate(
                      offset: const Offset(0, -10),
                      child: const CustomLinearProgress(value: 1)),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomTextField(
                    validator: ValidationUtils.validateRequired("Device price"),
                    controller: publishDeviceController.devicePriceController,
                    hintText: "Enter device price".tr,
                    title: "Device price".tr,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                    validator:
                        ValidationUtils.validateRequired("Write details"),
                    controller: publishDeviceController.detailsController,
                    hintText: "Write details".tr,
                    title: "Details".tr,
                    maxLine: 5,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Obx(
                    () => ImagePickContainer(
                      imageUrl: publishDeviceController.imageUrl.value,
                      title: "Click to Upload Device Photos",
                      imagePath: publishDeviceController.imagePath.value,
                      onTap: () {
                        log(publishDeviceController.imagePath.value);
                        ImageUtil.pickAndUpdateImage(
                            publishDeviceController.imagePath);
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  if (!isUpdate) ...[
                    Obx(() => checkBoxWithTitle(
                          publishDeviceController
                              .isSellerAgreeTermsChecked.value,
                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.dark14,
                              children: [
                                TextSpan(text: 'I agree to the '.tr),
                                TextSpan(
                                  text: 'privacy policy & terms'.tr,
                                  style: AppTextStyle.dark14
                                      .copyWith(color: AppColor.primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle click event
                                      print('Navigate to terms & conditions');
                                    },
                                ),
                                TextSpan(text: ' of Services'.tr),
                              ],
                            ),
                          ),
                          (newValue) => publishDeviceController
                              .toggleSellerAgreeTerms(newValue),
                        )),
                    // SizedBox(height: Get.height * 0.02),
                    Obx(() => checkBoxWithTitle(
                          publishDeviceController
                              .isSellerAccurateInfoChecked.value,
                          const TextWidget(
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              textAlign: TextAlign.start,
                              fontSize: 14),
                          (newValue) => publishDeviceController
                              .toggleSellerAccurateInfo(newValue),
                        )),
                    // SizedBox(height: Get.height * 0.02),
                    Obx(() => checkBoxWithTitle(
                          publishDeviceController.isSellerPayDuesChecked.value,
                          const TextWidget(
                            title:
                                "Commitment to pay meter app dues, estimated at 10% of the project value.",
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 14,
                            textAlign: TextAlign.start,
                          ),
                          (newValue) => publishDeviceController
                              .toggleSellerPayDues(newValue),
                        )),
                  ],
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  Obx(() => publishDeviceController.isLoading.value
                      ? const Align(
                          alignment: Alignment.topCenter,
                          child: CustomLoading())
                      : CustomButton(
                          title: "Continue".tr,
                          onTap: () {
                            if (isUpdate && deviceModel != null) {
                              log("Device Model ${deviceModel.deviceModel}");
                              publishDeviceController
                                  .updateDevice(deviceModel.id);
                            } else {
                              publishDeviceController
                                  .publishDeviceClick(_formKey);
                            }
                          })),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget checkBoxWithTitle(
    bool checkValue, Widget title, Function(bool?)? onChanged) {
  return Row(
    children: [
      Transform.scale(
        scale: 1.3,
        child: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: AppColor.primaryColor,
          checkColor: AppColor.whiteColor,
          // overlayColor: WidgetStateProperty<Color>,
          value: checkValue,
          onChanged: onChanged,
        ),
      ),
      Flexible(child: title),
    ],
  );
}