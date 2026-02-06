import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/main_auth_controller.dart';
import 'package:meter_app/controller/auth_controller/seller_auth_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/group_radio_button.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class SellerLoginMain extends StatelessWidget {
  final String userType;
  const SellerLoginMain({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerAuthController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Align(
      alignment: Alignment.topLeft,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            TextWidget(
              title: "Service Provider",
              textColor: AppColor.semiDarkGrey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Transform.translate(
              offset: Offset(-Get.width * 0.04, 0),
              child: Row(
                children: [
                  Obx(() => rowWithRadio(
                        'Company'.tr,
                        controller.selectedSellerServiceOption.value,
                        'Company',
                        (newValue) =>
                            controller.selectSellerServiceOption(newValue!),
                      )),
                  Obx(() => rowWithRadio(
                        'Establishment'.tr,
                        controller.selectedSellerServiceOption.value,
                        'Establishment',
                        (newValue) =>
                            controller.selectSellerServiceOption(newValue!),
                      )),
                ],
              ),
            ),
            CustomTextField(
              validator: ValidationUtils.validateRequired("Facility name"),
              controller: controller.facilityNameController,
              hintText: "Enter facility name",
              title: "Facility name".tr,
            ),
            CustomTextField(
              validator: ValidationUtils.validateRequired("Facility Number"),
              controller: controller.facilityNumberController,
              hintText: "Enter facility number",
              title: "Facility Number".tr,
              textInputType: TextInputType.number,
            ),
            CustomTextField(
              validator:
                  ValidationUtils.validateRequired("Commercial Registration"),
              controller: controller.commercialRegistrationController,
              hintText: "Enter Commercial Registration",
              title: "Commercial Registration".tr,
            ),
            CustomTextField(
              validator: ValidationUtils.validateRequired("Facility Activity"),
              controller: controller.facilityActivityController,
              hintText: "Activity will be here".tr,
              title: "Facility Activity".tr,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            MyCustomButton(
                title: "Register".tr,
                onTap: () {
                  // if (_formKey.currentState!.validate()) {
                  //   Get.to(const SellerGeneralInfo());
                  // } else {
                  //   ShortMessageUtils.showError("Please Fill all fields");
                  // }
                  Get.to(const SellerGeneralInfo());
                })
          ],
        ),
      ),
    );
  }
}
