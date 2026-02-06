import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/login_controller.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/useful_function_util.dart';
import 'package:meter_app/view/bottom_nav/home/home_screen.dart';
import 'package:meter_app/widget/verification_widget.dart';

import '../../bottom_nav/bottom_nav_main.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    log("Controller ${controller.fullPhoneNumber()}");
    return Obx(() => VerificationWidget(
          controller: controller.otpController,
          buttonTitle: "Verify Code",
          showResend: controller.showResendValue.value,
          showLoading: controller.verifyOtpLoading.value,
          onTap: () {
            // controller.verifyOtp();
            Get.offAll(const MainHomeScreen(userType: ConstantUtil.customer,));
          },
          onResendTap: () {
            controller.startResendTimer();
          },
          countryCode: UsefulFunctionUtil.formatPhoneNumber(
              controller.fullPhoneNumber()),
          phoneNumber: controller.phoneNumberController.text,
        ));
  }
}
