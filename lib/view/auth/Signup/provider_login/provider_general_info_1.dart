import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/provider_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/provider_login/provider_general_info_2.dart';
import 'package:meter_app/widget/backend/verification_bottom_sheet.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/new_text_field.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/textfield.dart';

class ProviderFirstGeneralInfo extends StatelessWidget {
  final String? userType;

  const ProviderFirstGeneralInfo({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProviderAuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        bottomNavigationBar: Container(
            height: Get.height * 0.08,
            margin: EdgeInsets.only(bottom: 10, left: 14, right: 14),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: MyCustomButton(
                  title: "Continue".tr,
                  onTap: () {
                    // if (_formKey.currentState!.validate() &&
                    //     controller.validateManagerPhoneNumber()) {
                    //   Get.to(const ProviderSecondGeneralInfo());
                    // } else {
                    //   if (!controller.validateManagerPhoneNumber()) {
                    //     ShortMessageUtils.showError(
                    //         "Please enter valid manager phone number");
                    //   } else {
                    //     ShortMessageUtils.showError("Please fill all fields");
                    //   }
                    // }
                    Get.to(ProviderSecondGeneralInfo(userType: userType));
                  }),
            )),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 2,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: NewTextField(
                    validator: ValidationUtils.validateRequired("Manager Name"),
                    controller: controller.managerNameController,
                    hintText: "manager name".tr,
                    title: "Enter manager name".tr,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => CustomTextFieldWithCountryPicker(
                      hintText: "115203867",
                      controller: controller.managerPhoneNumberController,
                      flagPath: controller.managerPhoneNumberFlagUri.value,
                      countryCode: (CountryCode countryCode) {
                        controller.onChangeFlag(countryCode.flagUri ?? "",
                            countryCode.dialCode ?? "", countryCode.code ?? "");
                      },
                      title: "Manager Phone Number".tr,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
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
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
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
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: NewTextField(
                    controller: controller.neighborhoodController,
                    title: "Enter Neighborhood (Optional)".tr,
                    hintText: "(Optional)".tr,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
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
            ),
          ),
        ),
      ),
    );
  }
}
