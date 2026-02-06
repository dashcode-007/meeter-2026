import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/customer_auth_controller.dart';
import 'package:meter_app/controller/auth_controller/provider_auth_controller.dart';
import 'package:meter_app/controller/auth_controller/seller_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth_new/general_info/general_info_step_2_screen.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/new_text_field.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';

class GeneralInfoScreen extends StatelessWidget {
  final String userType;

  const GeneralInfoScreen({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return _GeneralInfoContent(userType: userType);
  }
}

class _GeneralInfoContent extends StatelessWidget {
  final String userType;

  const _GeneralInfoContent({required this.userType});

  double get _progressWidth {
    switch (userType) {
      case ConstantUtil.customer:
        return 1.5;
      case ConstantUtil.seller:
        return 2.5;
      case ConstantUtil.provider:
        return 2.3;
      default:
        return 1.5;
    }
  }

  void _onContinue() {
    switch (userType) {
      case ConstantUtil.customer:
      case ConstantUtil.seller:
      case ConstantUtil.provider:
        Get.to(GeneralInfoStep2Screen(userType: userType));
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
        bottomNavigationBar: useBottomBar ? _buildContinueButton(formKey, _onContinue) : null,
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
                  onTap: userType == ConstantUtil.provider ? () => Get.back() : null,
                ),
                SizedBox(height: Get.height * 0.03),
                if (userType == ConstantUtil.customer) _buildCustomerForm(formKey),
                if (userType == ConstantUtil.seller) _buildSellerForm(formKey),
                if (userType == ConstantUtil.provider) _buildProviderForm(context, formKey),
                if (!useBottomBar) ...[
                  SizedBox(height: Get.height * 0.04),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
                    child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: _onContinue,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(GlobalKey<FormState> formKey, VoidCallback onContinue) {
    return Container(
      height: Get.height * 0.08,
      margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
      child: MyCustomButton(
        title: "Continue".tr,
        onTap: onContinue,
      ),
    );
  }

  Widget _buildCustomerForm(GlobalKey<FormState> formKey) {
    final controller = Get.put(CustomerAuthController());

    return Column(
      children: [
        Obx(
          () => GestureDetector(
            onTap: () => ImageUtil.pickAndUpdateImage(controller.imagePath),
            child: controller.imagePath.value == ""
                ? Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: Image.asset(
                      AppImage.pickImage,
                      height: Get.height * 0.17,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: ClipOval(
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
          padding: const EdgeInsets.only(left: 14.0, right: 14, top: 10, bottom: 10),
          child: NewTextField(
            hintText: "Address".tr,
            title: "Enter Address",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
          child: NewTextField(
            title: "Select City".tr,
            hintText: "City".tr,
            validator: ValidationUtils.validateRequired("City"),
            controller: controller.cityController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
          child: NewTextField(
            title: "Select Neighborhood".tr,
            hintText: "Neighborhood".tr,
            validator: ValidationUtils.validateRequired("Neighborhood"),
            controller: controller.neighborhoodController,
          ),
        ),
      ],
    );
  }

  Widget _buildSellerForm(GlobalKey<FormState> formKey) {
    final controller = Get.put(SellerAuthController());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Owner Name"),
            controller: controller.ownerNameController,
            title: "Enter owner name",
            hintText: "owner name",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
          child: Obx(
            () => CustomTextFieldWithCountryPicker(
              isVerifySucces: controller.verifyMessage.value == "Success",
              hintText: "115203867",
              controller: controller.phoneNumberController,
              flagPath: controller.phoneNumberFlagUri.value,
              countryShortCode: controller.phoneNumberCountryCode.value,
              countryCode: (CountryCode countryCode) {
                controller.onChangePhoneNumberFlag(
                  countryCode.flagUri ?? "",
                  countryCode.dialCode ?? "",
                  countryCode.code ?? "",
                );
              },
              onTapSuffix: () {
                if (controller.verifyMessage.value == "Success") {
                  ShortMessageUtils.showSuccess("Already verified");
                } else if (!controller.sendOtpLoading.value) {
                  controller.sendOtp();
                }
              },
              verifyColor: controller.verifyMessage.value == "Success"
                  ? AppColor.semiTransparentDarkGrey
                  : AppColor.primaryColor,
              verifyText: controller.sendOtpLoading.value
                  ? "Loading..."
                  : (controller.verifyMessage.value == "Success"
                      ? controller.verifyMessage.value
                      : "Verify"),
              title: "Phone Number".tr,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
          child: NewTextField(
            validator: ValidationUtils.validateRequired("Manager Name"),
            controller: controller.managerNameController,
            title: "Enter manager name".tr,
            hintText: "manager name".tr,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
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
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 12),
          child: NewTextField(
            validator: ValidationUtils.validateLengthRange("Description Of Services", 20, maxLength: 1000),
            controller: controller.descriptionOfServiceController,
            maxLines: 5,
            title: "Enter Description".tr,
            hintText: "description".tr,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }

  Widget _buildProviderForm(BuildContext context, GlobalKey<FormState> formKey) {
    final controller = Get.put(ProviderAuthController());

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
          child: NewTextField(
            title: "Enter owner name",
            hintText: "owner name",
            validator: ValidationUtils.validateRequired("The Owner Name"),
            controller: controller.ownerNameController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14),
          child: Obx(
            () => CustomTextFieldWithCountryPicker(
              isVerifySucces: controller.verifyMessage.value == "Success",
              hintText: "115203867",
              controller: controller.phoneNumberController,
              flagPath: controller.phoneNumberFlagUri.value,
              countryShortCode: controller.phoneNumberCountryCode.value,
              countryCode: (CountryCode countryCode) {
                controller.onChangePhoneNumberFlag(
                  countryCode.flagUri ?? "",
                  countryCode.dialCode ?? "",
                  countryCode.code ?? "",
                );
              },
              onTapSuffix: () {
                if (controller.verifyMessage.value == "Success") {
                  ShortMessageUtils.showSuccess("Already verified");
                } else if (!controller.sendOtpLoading.value) {
                  controller.sendOtp();
                }
              },
              verifyColor: controller.verifyMessage.value == "Success"
                  ? AppColor.semiTransparentDarkGrey
                  : AppColor.primaryColor,
              verifyText: controller.sendOtpLoading.value
                  ? "Loading..."
                  : (controller.verifyMessage.value == "Success"
                      ? controller.verifyMessage.value
                      : "Verify"),
              title: "Phone Number".tr,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
          child: NewTextField(
            title: "Commercial Registration Number",
            hintText: "12312313",
            validator: ValidationUtils.validateRequired("Commercial Registration"),
            controller: controller.commercialRegistrationController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
          child: NewTextField(
            title: "Select date",
            hintText: "Select date",
            validator: ValidationUtils.validateRequired("Date of commercial registration"),
            controller: controller.dateOfCommercialRegistrationController,
            prefixImagePath: AppImage.calender,
            readOnly: true,
            textInputType: TextInputType.number,
            onTap: () => controller.pickCommercialRegistrationDate(context),
          ),
        ),
        SizedBox(height: Get.height * 0.04),
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: ImagePickContainer(
              onTap: () {
                ImageUtil.pickAndUpdateFile(
                  controller.fileName,
                  controller.filePath,
                );
              },
              fileName: controller.fileName.value,
              isFile: controller.filePath.value != "",
              title: "Click to upload \n your papers",
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }
}
