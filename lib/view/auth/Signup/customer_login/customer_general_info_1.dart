import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/customer_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/textfield.dart';

import '../../../../routes/routes_name.dart';
import '../../../../widget/new_text_field.dart';
import '../../../services/publish_device/publish_device1.dart';

class CustomerFirstGeneralInfo extends StatelessWidget {
  final String? userType;
  const CustomerFirstGeneralInfo({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerAuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
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
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
                  child: NewTextField(
                    title: "Enter your password".tr,
                    hintText: "password".tr,
                    validator: ValidationUtils.validateRequired("Password"),
                    controller: controller.passwordController,
                    isObscure: controller.passwordHide.value,
                    showSuffix: true,
                    maxLines: controller.passwordHide.value ? 1 : null,
                    onSuffixIconTap: () {
                      controller.togglePassword();
                    },
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
                  child: NewTextField(
                    title: "Re-enter password".tr,
                    hintText: "re-enter password".tr,
                    validator: ValidationUtils.validateLengthRange(
                        "Confirm Password", 5),
                    controller: controller.confirmPasswordController,
                    isObscure: controller.confirmPasswordHide.value,
                    showSuffix: true,
                    maxLines: controller.passwordHide.value ? 1 : null,
                    onSuffixIconTap: () {
                      controller.toggleConfirmPassword();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
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
                height: Get.height * 0.04,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Obx(
                    () => controller.customerLoading.value
                        ? const CustomLoading()
                        : MyCustomButton(
                            title: "Continue".tr,
                            onTap: () {
                              // controller.completeCustomerRegistration(_formKey);
                              // Get.offAllNamed(RoutesName.sellerFaceAuth);
                              Get.offAll(SellerFaceAuth(
                                userType: userType,
                              ));
                            }),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
