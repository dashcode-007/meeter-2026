import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/customer_auth_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/routes/routes_name.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/customer_login/customer_general_info.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/textfield.dart';
import '../../../../widget/text_fied_with_country_picker.dart';

class CustomerLoginMain extends StatelessWidget {
  final String userType;
  const CustomerLoginMain({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerAuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.04,
            ),
            CustomTextField(
                validator: ValidationUtils.validateRequired("Name"),
                controller: controller.nameController,
                hintText: "Enter Your Name".tr,
                title: "Name".tr),
            CustomTextField(
                validator: ValidationUtils.validateEmail,
                controller: controller.emailController,
                hintText: "Enter your email",
                title: "Email".tr),
            Obx(
              () => CustomTextFieldWithCountryPicker(
                isVerifySucces: controller.verifyMessage.value ==
                    "Success", //"Success"  change when deliver to client
                hintText: "115203867",
                controller: controller.phoneNumberController,
                flagPath: controller.flagUri.value,
                countryShortCode: controller.countryCode.value,
                countryCode: (CountryCode countryCode) {
                  controller.onChangeFlag(countryCode.flagUri ?? "",
                      countryCode.dialCode ?? "", countryCode.code ?? "");
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
            SizedBox(
              height: Get.height * 0.07,
            ),
            MyCustomButton(
                title: "Register".tr,
                onTap: () {
                  // if (_formKey.currentState!.validate() &&
                  //         controller.verifyMessage.value ==
                  //             "Success" //Change to Success
                  //     ) {
                  //   Get.toNamed(RoutesName.customerGeneralInfoScreen);
                  // } else {
                  //   if (!controller.validatePhoneNumber()) {
                  //     ShortMessageUtils.showError(
                  //         "Please enter valid phone number");
                  //   } else if (controller.verifyMessage.value != "Success") {
                  //     ShortMessageUtils.showError("Please verify first");
                  //   } else {
                  //     ShortMessageUtils.showError("Please fill all fields");
                  //   }
                  // }
                  // Get.toNamed(RoutesName.customerGeneralInfoScreen);
                  Get.to(CustomerGeneralInfo(userType: userType,));
                })
          ],
        ),
      ),
    );
  }
}
