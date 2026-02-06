import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/provider_auth_controller.dart';
import 'package:meter_app/controller/auth_controller/seller_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/new_text_field.dart';
import 'package:meter_app/widget/text_widget.dart';

class GeneralInfoStep3Screen extends StatelessWidget {
  final String userType;

  const GeneralInfoStep3Screen({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return _GeneralInfoStep3Content(userType: userType);
  }
}

class _GeneralInfoStep3Content extends StatelessWidget {
  final String userType;

  const _GeneralInfoStep3Content({required this.userType});

  void _onContinue() {
    Get.offAll(SellerFaceAuth(userType: userType));
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: userType == ConstantUtil.provider
            ? AppColor.whiteColor
            : AppColor.scaffoldColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 1.4,
                ),
                SizedBox(height: Get.height * 0.03),
                if (userType == ConstantUtil.seller) _buildSellerForm(),
                if (userType == ConstantUtil.provider) _buildProviderForm(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    if (userType == ConstantUtil.seller) {
      final controller = Get.find<SellerAuthController>();
      return Obx(
        () => controller.sellerLoading.value
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(
                  left: Get.width / 2.3,
                  right: Get.width / 2.3,
                ),
                height: Get.height * 0.04,
                child: const CustomLoading(),
              )
            : Container(
                height: Get.height * 0.12,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: MyCustomButton(
                    title: "Continue".tr,
                    onTap: _onContinue,
                  ),
                ),
              ),
      );
    }

    if (userType == ConstantUtil.provider) {
      final controller = Get.find<ProviderAuthController>();
      return Obx(
        () => controller.isLoading.value
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(
                  left: Get.width / 2.3,
                  right: Get.width / 2.3,
                ),
                height: Get.height * 0.04,
                child: const CustomLoading(),
              )
            : Container(
                height: Get.height * 0.08,
                margin: EdgeInsets.only(
                  bottom: Get.height * 0.05,
                  left: 14,
                  right: 14,
                ),
                child: MyCustomButton(
                  title: "Continue".tr,
                  onTap: _onContinue,
                ),
              ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSellerForm() {
    final controller = Get.find<SellerAuthController>();

    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: ImagePickContainer(
              title: "Click to upload \n your papers",
              onTap: () {
                ImageUtil.pickAndUpdateFile(
                  controller.pdfFileName,
                  controller.pdfFilePath,
                );
              },
              fileName: controller.pdfFileName.value,
              isFile: controller.pdfFilePath.value != "",
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.03),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: NewTextField(
              validator: ValidationUtils.validateLengthRange("Password", 5),
              onSuffixIconTap: controller.togglePassword,
              controller: controller.passwordController,
              isObscure: controller.passwordHide.value,
              showSuffix: true,
              maxLines: controller.passwordHide.value ? 1 : null,
              hintText: "Enter your password".tr,
              title: "Password".tr,
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: NewTextField(
              validator: ValidationUtils.validateLengthRange("Confirm Password", 5),
              controller: controller.confirmPasswordController,
              onSuffixIconTap: controller.toggleConfirmPassword,
              isObscure: controller.confirmPasswordHide.value,
              showSuffix: true,
              maxLines: controller.confirmPasswordHide.value ? 1 : null,
              hintText: "Re-enter password".tr,
              title: "Confirm Password".tr,
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.04),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: checkBoxWithTitle(
              controller.isSellerAgreeTermsChecked.value,
              RichText(
                text: TextSpan(
                  style: AppTextStyle.dark14,
                  children: [
                    TextSpan(text: 'I agree to the '.tr),
                    TextSpan(
                      text: 'terms & conditions'.tr,
                      style: AppTextStyle.dark14.copyWith(color: AppColor.primaryColor),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(text: ' by creating account.'.tr),
                  ],
                ),
              ),
              controller.toggleSellerAgreeTerms,
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: checkBoxWithTitle(
              controller.isSellerAccurateInfoChecked.value,
              const TextWidget(
                textAlign: TextAlign.start,
                title: "Commitment to the accuracy of information.",
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 14,
              ),
              controller.toggleSellerAccurateInfo,
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: checkBoxWithTitle(
              controller.isSellerPayDuesChecked.value,
              const TextWidget(
                textAlign: TextAlign.start,
                title:
                    "Commitment to pay meter app dues, estimated at 10% of the project value.",
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 14,
              ),
              controller.toggleSellerPayDues,
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.05),
      ],
    );
  }

  Widget _buildProviderForm() {
    final controller = Get.find<ProviderAuthController>();

    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: GestureDetector(
              onTap: () => ImageUtil.pickAndUpdateImage(controller.imagePath),
              child: controller.imagePath.value == ""
                  ? Image.asset(
                      AppImage.pickImage,
                      height: Get.height * 0.17,
                    )
                  : ClipOval(
                      child: Image.file(
                        File(controller.imagePath.value),
                        height: Get.height * 0.17,
                        width: Get.height * 0.17,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.03),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: NewTextField(
              validator: ValidationUtils.validateLengthRange("Password", 5),
              onSuffixIconTap: controller.togglePassword,
              controller: controller.passwordController,
              isObscure: controller.passwordHide.value,
              showSuffix: true,
              maxLines: controller.passwordHide.value ? 1 : null,
              title: "Enter your password".tr,
              hintText: "password".tr,
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: NewTextField(
              validator: ValidationUtils.validateLengthRange("Confirm Password", 5),
              controller: controller.confirmPasswordController,
              onSuffixIconTap: controller.toggleConfirmPassword,
              isObscure: controller.confirmPasswordHide.value,
              showSuffix: true,
              maxLines: controller.confirmPasswordHide.value ? 1 : null,
              title: "Re-enter password".tr,
              hintText: "re-enter password".tr,
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.03),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: checkBoxWithTitle(
              controller.isAgreeTermsChecked.value,
              RichText(
                text: TextSpan(
                  style: AppTextStyle.dark14.copyWith(fontSize: 12),
                  children: [
                    TextSpan(text: 'I agree to the '.tr),
                    TextSpan(
                      text: 'terms & conditions'.tr,
                      style: AppTextStyle.dark14.copyWith(color: AppColor.primaryColor),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    TextSpan(text: ' by creating account.'.tr),
                  ],
                ),
              ),
              controller.toggleAgreeTerms,
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.04),
      ],
    );
  }
}
