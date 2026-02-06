import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/customer_auth_controller.dart';
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
import 'package:meter_app/view/auth_new/general_info/general_info_step_3_screen.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/new_text_field.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';

class GeneralInfoStep2Screen extends StatelessWidget {
  final String userType;

  const GeneralInfoStep2Screen({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return _GeneralInfoStep2Content(userType: userType);
  }
}

class _GeneralInfoStep2Content extends StatelessWidget {
  final String userType;

  const _GeneralInfoStep2Content({required this.userType});

  double get _progressWidth {
    switch (userType) {
      case ConstantUtil.customer:
        return 1.4;
      case ConstantUtil.seller:
        return 1.7;
      case ConstantUtil.provider:
        return 2;
      default:
        return 1.4;
    }
  }

  void _onContinue() {
    switch (userType) {
      case ConstantUtil.customer:
        Get.offAll(SellerFaceAuth(userType: userType));
        break;
      case ConstantUtil.seller:
      case ConstantUtil.provider:
        Get.to(GeneralInfoStep3Screen(userType: userType));
        break;
      default:
        Get.snackbar('Error', 'Invalid user type', snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final useBottomBar = userType == ConstantUtil.provider;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        bottomNavigationBar: useBottomBar ? _buildContinueButton(_onContinue) : null,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: _progressWidth,
                ),
                SizedBox(height: Get.height * 0.03),
                if (userType == ConstantUtil.customer) _buildCustomerForm(),
                if (userType == ConstantUtil.seller) _buildSellerForm(),
                if (userType == ConstantUtil.provider) _buildProviderForm(),
                if (!useBottomBar) ...[
                  SizedBox(height: Get.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: _buildContinueWidget(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(VoidCallback onContinue) {
    return Container(
      height: Get.height * 0.08,
      margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
      child: MyCustomButton(title: "Continue".tr, onTap: onContinue),
    );
  }

  Widget _buildContinueWidget() {
    if (userType == ConstantUtil.customer) {
      final controller = Get.find<CustomerAuthController>();
      return Obx(
        () => controller.customerLoading.value
            ? const CustomLoading()
            : MyCustomButton(title: "Continue".tr, onTap: _onContinue),
      );
    }
    return MyCustomButton(title: "Continue".tr, onTap: _onContinue);
  }

  Widget _buildCustomerForm() {
    final controller = Get.find<CustomerAuthController>();

    return Column(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
            child: NewTextField(
              title: "Enter your password".tr,
              hintText: "password".tr,
              validator: ValidationUtils.validateRequired("Password"),
              controller: controller.passwordController,
              isObscure: controller.passwordHide.value,
              showSuffix: true,
              maxLines: controller.passwordHide.value ? 1 : null,
              onSuffixIconTap: controller.togglePassword,
            ),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
            child: NewTextField(
              title: "Re-enter password".tr,
              hintText: "re-enter password".tr,
              validator: ValidationUtils.validateLengthRange("Confirm Password", 5),
              controller: controller.confirmPasswordController,
              isObscure: controller.confirmPasswordHide.value,
              showSuffix: true,
              maxLines: controller.passwordHide.value ? 1 : null,
              onSuffixIconTap: controller.toggleConfirmPassword,
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
                  style: AppTextStyle.dark14,
                  children: [
                    TextSpan(text: 'I agree to the '.tr),
                    TextSpan(
                      text: 'terms & conditions'.tr,
                      style: AppTextStyle.dark14.copyWith(color: AppColor.primaryColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to terms & conditions page
                        },
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

  Widget _buildSellerForm() {
    final controller = Get.find<SellerAuthController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(14.0),
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
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Region"),
            controller: controller.regionController,
            hintText: "Enter Region".tr,
            title: "Region".tr,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("City"),
            hintText: "Select City".tr,
            title: "City".tr,
            controller: controller.cityController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Neighborhood"),
            controller: controller.neighborhoodController,
            hintText: "Select Neighborhood".tr,
            title: "Neighborhood".tr,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Location"),
            controller: controller.locationController,
            hintText: "Location".tr,
            title: "Location".tr,
            prefixImagePath: AppImage.location,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }

  Widget _buildProviderForm() {
    final controller = Get.find<ProviderAuthController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Manager Name"),
            controller: controller.managerNameController,
            hintText: "manager name".tr,
            title: "Enter manager name".tr,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: Obx(
            () => CustomTextFieldWithCountryPicker(
              hintText: "115203867",
              controller: controller.managerPhoneNumberController,
              flagPath: controller.managerPhoneNumberFlagUri.value,
              countryCode: (CountryCode countryCode) {
                controller.onChangeFlag(
                  countryCode.flagUri ?? "",
                  countryCode.dialCode ?? "",
                  countryCode.code ?? "",
                );
              },
              title: "Manager Phone Number".tr,
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: Row(
            children: [
              Expanded(
                child: NewTextField(
                  validator: ValidationUtils.validateRequired("Region"),
                  controller: controller.regionController,
                  title: "Enter Region".tr,
                  hintText: "region".tr,
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Expanded(
                child: NewTextField(
                  controller: controller.cityController,
                  title: "Enter City (Optional)".tr,
                  hintText: "(Optional)".tr,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            controller: controller.neighborhoodController,
            title: "Enter Neighborhood (Optional)".tr,
            hintText: "(Optional)".tr,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Location"),
            controller: controller.locationController,
            title: "Location".tr,
            hintText: "Location".tr,
            prefixImagePath: AppImage.location,
          ),
        ),
      ],
    );
  }
}
