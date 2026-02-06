import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/login_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/view/auth/Login/verification_screen.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/text_widget.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(
          () => CustomTextFieldWithCountryPicker(
            hintText: "115203867",
            controller: controller.phoneNumberController,
            flagPath: controller.flagUri.value,
            countryCode: (CountryCode countryCode) {
              controller.onChangeFlag(countryCode.flagUri ?? "",
                  countryCode.dialCode ?? "", countryCode.code ?? "");
            },
            title: "Phone Number".tr,
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Transform.translate(
          offset: const Offset(-10, 0),
          child: Obx(() => checkBoxWithTitle(
                controller.isChecked.value,
                const TextWidget(
                    title: "Remember me",
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 14),
                (newValue) => controller.toggleCheckbox(newValue),
              )),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(() => controller.sendCodeLoading.value
            ? const CustomLoading()
            : MyCustomButton(
                title: "Send Code".tr,
                onTap: () {
                  // controller.onSendCode(context);
                  // Get.put(SellerAuthController()).authenticatePhoneNumber(context);
                  Get.to(const VerificationScreen());
                }))
      ],
    );
  }
}
