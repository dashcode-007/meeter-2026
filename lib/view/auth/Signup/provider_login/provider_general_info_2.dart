import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/provider_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/pref_util.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/textfield.dart';

import '../../../../widget/custom_loading.dart';
import '../../../../widget/new_text_field.dart';

class ProviderSecondGeneralInfo extends StatelessWidget {
final String? userType;
  const ProviderSecondGeneralInfo({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderAuthController>();

    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        bottomNavigationBar: Obx(() => controller.isLoading.value
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(
                    left: Get.width / 2.3, right: Get.width / 2.3),
                height: Get.height * 0.04,
                child: const CustomLoading())
            : Container(
                height: Get.height * 0.08,
                margin: EdgeInsets.only(
                    bottom: Get.height * 0.05, left: 14, right: 14),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: () {
                        // controller.completeProviderRegistration(_formKey);
                        Get.offAll(  SellerFaceAuth(userType: userType,));
                        log("type is ${userType!}");

                      }),
                ))),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 1.4,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: GestureDetector(
                      onTap: () {
                        ImageUtil.pickAndUpdateImage(controller.imagePath);
                      },
                      child: controller.imagePath.value == ""
                          ? Image.asset(
                              AppImage.pickImage,
                              height: Get.height * 0.17,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(controller.imagePath.value),
                                height: Get.height * 0.17,
                                width: Get.height *
                                    0.17, // Ensure the width is the same as the height for a circle
                                fit: BoxFit
                                    .cover, // This will ensure the image covers the circle completely
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: NewTextField(
                          validator: ValidationUtils.validateLengthRange(
                              "Password", 5),
                          onSuffixIconTap: () {
                            controller.togglePassword();
                          },
                          controller: controller.passwordController,
                          isObscure: controller.passwordHide.value,
                          showSuffix: true,
                        maxLines: controller.passwordHide.value ? 1 : null,

                        title: "Enter your password".tr,
                        hintText: "password".tr,
                         ),
                    )),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: NewTextField(
                          validator: ValidationUtils.validateLengthRange(
                              "Confirm Password", 5),
                          controller: controller.confirmPasswordController,
                          onSuffixIconTap: () {
                            controller.toggleConfirmPassword();
                          },
                          isObscure: controller.confirmPasswordHide.value,
                          showSuffix: true,
                        maxLines: controller.confirmPasswordHide.value ? 1 : null,

                        title: "Re-enter password".tr,
                        hintText: "re-enter password".tr,
                         ),
                    )),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(() => checkBoxWithTitle(
                      controller.isAgreeTermsChecked.value,
                      RichText(
                        text: TextSpan(
                          style: AppTextStyle.dark14.copyWith(fontSize: 12),
                          children: [
                            TextSpan(text: 'I agree to the '.tr),
                            TextSpan(
                              text: 'terms & conditions'.tr,
                              style: AppTextStyle.dark14
                                  .copyWith(color: AppColor.primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Handle click event
                                  print('Navigate to terms & conditions');
                                },
                            ),
                            TextSpan(text: ' by creating account.'.tr),
                          ],
                        ),
                      ),
                      (newValue) => controller.toggleAgreeTerms(newValue),
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
