import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/customer_controller/request_service_controler.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/image_util.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/auth/Signup/seller_login/general_info_2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/image_pick_container.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/group_radio_button.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/text_fied_with_country_picker.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class RequestSecondService extends StatelessWidget {
  const RequestSecondService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestServiceController>();
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(
          () => controller.loading.value
              ? Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(
                      left: Get.width / 2.3, right: Get.width / 2.3),
                  height: Get.height * 0.04,
                  child: const CustomLoading())
              : Container(
                  height: Get.height * 0.12,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: MyCustomButton(
                        title: "Submit Request",
                        onTap: () {
                          // Get.offAllNamed(RoutesName.sellerFaceAuth);
                          controller.onContinueClick(_formKey);
                        }),
                  )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomHeader(
                  title: "Request a service",
                  showProgress: true,
                  progressWidth: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      const TextWidget(
                          title: "Applicant Type",
                          textColor: AppColor.semiDarkGrey,
                          fontSize: 16),
                      Obx(
                        () => Row(
                          children: [
                            rowWithRadio(
                              fontSize: 14,
                              "Owner",
                              controller.selectedTypeOfApplicant.value,
                              "Owner",
                              (newValue) =>
                                  controller.typeOfApplicant(newValue!),
                            ),
                            rowWithRadio(
                              fontSize: 14,
                              "Dealer",
                              controller.selectedTypeOfApplicant.value,
                              "Dealer",
                              (newValue) =>
                                  controller.typeOfApplicant(newValue!),
                            ),
                          ],
                        ),
                      ),
                      CustomTextField(
                          validator:
                              ValidationUtils.validateRequired("Agency Number"),
                          showSpace: true,
                          hintText: "Agency Number",
                          textInputType: TextInputType.number,
                          title: "",
                          controller: controller.agencyNumberController),
                      CustomTextField(
                          validator: ValidationUtils.validateRequired(
                              "Applicant's name"),
                          hintText: "Enter Applicant's name",
                          title: "Applicant's name",
                          controller: controller.applicantsNameController),
                      Obx(
                        () => CustomTextFieldWithCountryPicker(
                          hintText: "115203867",
                          controller: controller.phoneNumberController,
                          flagPath: controller.flagUri.value,
                          countryCode: (CountryCode countryCode) {
                            controller.onChangeFlag(
                                countryCode.flagUri ?? "",
                                countryCode.dialCode ?? "",
                                countryCode.code ?? "");
                          },
                          title: "Phone Number".tr,
                        ),
                      ),
                      CustomTextField(
                          validator:
                              ValidationUtils.validateRequired("ID Number"),
                          hintText: "Enter id number",
                          textInputType: TextInputType.number,
                          title: "ID Number",
                          controller: controller.agencyNumberController),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Obx(
                        () => ImagePickContainer(
                          title: "Click to upload",
                          onTap: () {
                            ImageUtil.pickAndUpdateFile(
                                controller.fileName, controller.filePath);
                          },
                          fileName: controller.fileName.value,
                          isFile: controller.filePath.value != "",
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Obx(() => checkBoxWithTitle(
                            controller.isPayMeterChecked.value,
                            const TextWidget(
                                title:
                                    "Commitment to pay Meter application dues",
                                textColor: AppColor.semiTransparentDarkGrey,
                                textAlign: TextAlign.start,
                                fontSize: 14),
                            (newValue) => controller.togglePayMeter(newValue),
                          )),
                      Obx(() => checkBoxWithTitle(
                            controller.isAccuracyChecked.value,
                            const TextWidget(
                              title:
                                  "Commitment to the accuracy of information.",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 14,
                              textAlign: TextAlign.start,
                            ),
                            (newValue) =>
                                controller.toggleAccuracyChecked(newValue),
                          )),
                      Obx(() => checkBoxWithTitle(
                            controller.isAgreeTermsChecked.value,
                            RichText(
                              text: TextSpan(
                                style: AppTextStyle.dark14,
                                children: [
                                  TextSpan(text: 'Agree to the '.tr),
                                  TextSpan(
                                    text: 'privacy policy & terms'.tr,
                                    style: AppTextStyle.dark14
                                        .copyWith(color: AppColor.primaryColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        log('Navigate to terms & conditions');
                                      },
                                  ),
                                  TextSpan(text: ' ${"of service"}'.tr),
                                ],
                              ),
                            ),
                            (newValue) => controller.toggleAgreeTerms(newValue),
                          )),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
