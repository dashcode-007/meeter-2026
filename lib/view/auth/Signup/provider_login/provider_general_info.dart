import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/provider_auth_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/provider_login/provider_general_info_1.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/new_text_field.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/textfield.dart';
import '../../../../res/app_assets/app_image.dart';

class ProviderGeneralInfo extends StatelessWidget {
  final String? userType;

  const ProviderGeneralInfo({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProviderAuthController());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        bottomNavigationBar: Container(
          height: Get.height * 0.08,
          margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
          child: MyCustomButton(
              title: "Continue".tr,
              onTap: () {
                // if (_formKey.currentState!.validate() &&
                //         controller.filePath.isNotEmpty &&
                //         controller.verifyMessage.value ==
                //             "Success" //Change to =="Success"
                //     ) {
                //   Get.to(const ProviderFirstGeneralInfo());
                // } else {
                //   if (controller.verifyMessage.value != "Success") {
                //     ShortMessageUtils.showError(
                //         "Please verify your phone number");
                //   } else if (controller.filePath.value.isEmpty) {
                //     ShortMessageUtils.showError("Please upload your papers");
                //   } else if (controller.verifyMessage.value != "Success") {
                //     ShortMessageUtils.showError("Please verify first");
                //   } else {
                //     ShortMessageUtils.showError("Please fill all fields");
                //   }
                // }
                Get.to(ProviderFirstGeneralInfo(userType: userType));
              }),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 2.3,
                  onTap: () => Get.back(),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                    child: NewTextField(
                      title: "Enter owner name",
                      hintText: "owner name",
                      validator:
                          ValidationUtils.validateRequired("The Owner Name"),
                      controller: controller.ownerNameController,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => CustomTextFieldWithCountryPicker(
                      isVerifySucces: controller.verifyMessage.value ==
                          "Success", //"Success"  change when deliver to client
                      hintText: "115203867",
                      controller: controller.phoneNumberController,
                      flagPath: controller.phoneNumberFlagUri.value,
                      countryShortCode: controller.phoneNumberCountryCode.value,
                      countryCode: (CountryCode countryCode) {
                        controller.onChangePhoneNumberFlag(
                            countryCode.flagUri ?? "",
                            countryCode.dialCode ?? "",
                            countryCode.code ?? "");
                      },
                      onTapSuffix: () {
                        if (controller.verifyMessage.value == "Success") {
                          ShortMessageUtils.showSuccess("Already verified");
                        } else if (controller.sendOtpLoading.value) {
                        } else {
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
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                    child: NewTextField(
                      title: "Commercial Registration Number",
                      hintText: "12312313",
                      validator: ValidationUtils.validateRequired(
                          "Commercial Registration"),
                      controller: controller.commercialRegistrationController,
                    )),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 14, top: 14.0),
                    child: NewTextField(
                      title: "Select date",
                      hintText: "Select date",
                      validator: ValidationUtils.validateRequired(
                          "Date of commercial registration"),
                      controller:
                          controller.dateOfCommercialRegistrationController,
                      prefixImagePath: AppImage.calender,
                      readOnly: true,
                      textInputType: TextInputType.number,
                      onTap: () {
                        controller.pickCommercialRegistrationDate(context);
                      },
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(
                  () => Padding(
                    padding: EdgeInsets.only(left: 14.0, right: 14),
                    child: ImagePickContainer(
                        onTap: () {
                          ImageUtil.pickAndUpdateFile(
                              controller.fileName, controller.filePath);
                        },
                        fileName: controller.fileName.value,
                        isFile: controller.filePath.value != "",
                        title: "Click to upload \n your papers"),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
