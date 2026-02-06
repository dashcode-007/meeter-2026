import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/customer_controller/request_service_consolation_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/widget/group_radio_button.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class ConsolationMain extends StatelessWidget {
  const ConsolationMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RequestServiceConsolationController());
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SingleChildScrollView(
        child: Form(
          key: controller.consolationFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  validator:
                      ValidationUtils.validateRequired("Consolation Title"),
                  hintText: "Enter consolation title",
                  title: "Consolation Title",
                  controller: controller.titleController),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const TextWidget(
                title: "Consolation Type",
                textColor: AppColor.semiDarkGrey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Transform.translate(
                offset: Offset(-Get.width * 0.046, 0),
                child: Row(
                  children: [
                    rowWithRadio(
                      fontSize: 14,
                      "Real estate",
                      controller.selectedTypeOfConsolation.value,
                      "Real estate",
                      (newValue) =>
                          controller.selectTypeOfConsolation(newValue!),
                    ),
                    rowWithRadio(
                      fontSize: 14,
                      "Engineering",
                      controller.selectedTypeOfConsolation.value,
                      "Engineering",
                      (newValue) =>
                          controller.selectTypeOfConsolation(newValue!),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                  validator: ValidationUtils.validateRequired("Details"),
                  maxLine: 5,
                  hintText: "Write Details",
                  title: "Details",
                  controller: controller.detailsController),
              CustomTextField(
                  validator:
                      ValidationUtils.validateRequired("Applicant's name"),
                  hintText: "Enter Applicant's name",
                  title: "Applicant's name",
                  controller: controller.detailsController),
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
                height: Get.height * 0.03,
              ),
              // CustomButton(
              //     title: "Continue",
              //     onTap: () {
              //       if (_formKey.currentState!.validate() &&
              //           controller.validatePhoneNumber()) {
              //         Get.to(ConsolationRequestService());
              //       } else if (!controller.validatePhoneNumber()) {
              //         ShortMessageUtils.showError(
              //             "Please enter valid phone number");
              //       } else {
              //         ShortMessageUtils.showError(
              //             "Please enter valid phone number");
              //       }
              //     }
              //     )
            ],
          ),
        ),
      ),
    );
  }
}
