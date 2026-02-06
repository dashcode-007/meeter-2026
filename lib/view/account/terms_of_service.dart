import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/bottom_nav_controller/account_controller/profile_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/text_widget.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              CustomHeader(title: "Terms Of Services".tr),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextWidget(
                    textAlign: TextAlign.start,
                    title: profileController.termsOfService,
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
