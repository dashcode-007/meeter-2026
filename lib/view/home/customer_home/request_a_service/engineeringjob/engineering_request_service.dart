import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/customer_controller/engineering_request_service_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
 import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

import '../../../../services/publish_device/publish_device1.dart';

class EngineeringRequestService extends StatelessWidget {
  const EngineeringRequestService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EngineeringRequestServiceController>();
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CustomHeader(
                  title: "Request a service",
                  showProgress: true,
                  progressWidth: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      CustomTextField(
                          validator: ValidationUtils.validateRequired(
                              "Preferred city work in"),
                          hintText: "Enter city Name",
                          title: "Preferred city work in",
                          controller: controller.cityController),
                      CustomTextField(
                          hintText: "Enter email",
                          title: "Email",
                          richText: "(Optional)",
                          controller: controller.emailController),
                      CustomTextField(
                          validator: ValidationUtils.validateRequired("Name"),
                          hintText: "Enter name",
                          title: "Name",
                          controller: controller.nameController),
                      Obx(
                        () => CustomTextFieldWithCountryPicker(
                          hintText: "115203867",
                          controller: controller.phoneNumberController,
                          flagPath: controller.flagUri.value,
                          countryCode: (CountryCode countryCode) {
                            controller.onChangeFlag(
                                countryCode.flagUri ?? "",
                                countryCode.dialCode ?? "",
                                countryCode.code ?? "");
                          },
                          title: "Phone Number".tr,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Obx(
                        () => ImagePickContainer(
                          title: "Click to upload",
                          onTap: () {
                            ImageUtil.pickAndUpdateFile(
                                controller.fileName, controller.filePath);
                          },
                          fileName: controller.fileName.value,
                          isFile: controller.filePath.value != "",
                        ),
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Obx(() => checkBoxWithTitle(
                            controller.isPayMeterChecked.value,
                            const TextWidget(
                                title:
                                    "Commitment to pay Meter application dues",
                                textColor: AppColor.semiTransparentDarkGrey,
                                textAlign: TextAlign.start,
                                fontSize: 14),
                            (newValue) => controller.togglePayMeter(newValue),
                          )),
                      Obx(() => checkBoxWithTitle(
                            controller.isAccuracyChecked.value,
                            const TextWidget(
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              textAlign: TextAlign.start,
                            ),
                            (newValue) =>
                                controller.toggleAccuracyChecked(newValue),
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
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Obx(() => controller.isLoading.value
                          ? const CustomLoading()
                          : CustomButton(
                              title: "Submit Request",
                              onTap: () {
                                controller.completeEngineeringJob(_formKey);

                                // Get.to(const EngineeringSpecialization());
                              }))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
