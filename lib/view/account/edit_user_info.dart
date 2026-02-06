import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/account_controller/edit_account_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class EditUserInfo extends StatelessWidget {
  const EditUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditAccountController());
    return Container(
      height: Get.height * 0.87,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: TextWidget(
                    title: "Change User Information".tr,
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 18),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Image.asset(
                AppImage.editImage,
                // AppImage.uploadYouPhoto,
                width: Get.width * 0.30,
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              CustomTextField(
                  controller: controller.nameController,
                  hintText: "Enter Your Name".tr,
                  title: "Name".tr),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField(
                  controller: controller.emailController,
                  hintText: "test123@gmail.com",
                  title: "Email".tr),
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
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.cityController,
                      readOnly: true,
                      title: "City".tr,
                      hintText: "Select".tr,
                      onChangeDropDown: (newValue) {},
                      dropDownItems: ["Faisalabad".tr, "Lahore".tr],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.neighborhoodController,
                      title: "Neighborhood".tr,
                      hintText: "Select".tr,
                      readOnly: true,
                      onChangeDropDown: (newValue) {},
                      dropDownItems: ["Faisalabad".tr, "Lahore".tr],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Row(
                children: [
                  Expanded(
                      child: MyCustomButton(
                    title: "Cancel".tr,
                    textColor: AppColor.semiTransparentDarkGrey,
                    backgroundColor: Colors.transparent,
                    onTap: () {
                      Get.back();
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButton(
                          title: "Save".tr,
                          onTap: () {
                            Get.back();
                          }))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
