import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/auth_controller/customer_auth_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/customer_login/customer_general_info_1.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/textfield.dart';
import 'package:meter_app/res/app_color/app_color.dart';

import '../../../../widget/new_text_field.dart';

class CustomerGeneralInfo extends StatelessWidget {
  final String? userType;
  const CustomerGeneralInfo({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerAuthController());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(
                  showProgress: true,
                  title: "General Info".tr,
                  progressWidth: 1.5,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Obx(
                  () => GestureDetector(
                      onTap: () {
                        ImageUtil.pickAndUpdateImage(controller.imagePath);
                      },
                      child: controller.imagePath.value == ""
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, right: 14),
                              child: Image.asset(
                                AppImage.pickImage,
                                height: Get.height * 0.17,
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 14.0, right: 14),
                              child: ClipOval(
                                child: Image.file(
                                  File(controller.imagePath.value),
                                  height: Get.height * 0.17,
                                  width: Get.height *
                                      0.17, // Ensure the width is the same as the height for a circle
                                  fit: BoxFit
                                      .cover, // This will ensure the image covers the circle completely
                                ),
                              ),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14.0, right: 14, top: 10, bottom: 10),
                  child: NewTextField(
                    hintText: "Address".tr,
                    title: "Enter Address",
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
                  child: NewTextField(
                    title: "Select City".tr,
                    hintText: "City".tr,
                    validator: ValidationUtils.validateRequired("City"),
                    controller: controller.cityController,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
                  child: NewTextField(
                    title: "Select Neighborhood".tr,
                    hintText: "Neighborhood".tr,
                    validator: ValidationUtils.validateRequired("Neighborhood"),
                    controller: controller.neighborhoodController,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 14.0, right: 14, bottom: 10),
                  child: MyCustomButton(
                      title: "Continue".tr,
                      onTap: () {
                        //   // if (_formKey.currentState!.validate() &&
                        //   //     controller.imagePath.value != "") {
                        //   //   Get.to(const CustomerFirstGeneralInfo());
                        //   // } else {
                        //   //   if (controller.imagePath.value == "") {
                        //   //     ShortMessageUtils.showError(
                        //   //         "Please pick image first");
                        //   //   } else {
                        //   //     ShortMessageUtils.showError(
                        //   //         "Please fill all fields");
                        //   //   }
                        Get.to(CustomerFirstGeneralInfo(
                          userType: userType,
                        ));
                        //   }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
