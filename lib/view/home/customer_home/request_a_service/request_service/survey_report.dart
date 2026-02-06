import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/customer_controller/request_service_controler.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/group_radio_button.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class SurveyReport extends StatelessWidget {
  const SurveyReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestServiceController>();
    return Container(
      height: Get.height * 0.87,
      decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          )),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Flexible(
                          child: TextWidget(
                            textAlign: TextAlign.start,
                            title:
                                "What is your purpose for issuing a survey report?",
                            textColor: AppColor.semiDarkGrey,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Transform.translate(
                          offset: Offset(0, -Get.height * 0.015),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Image.asset(
                              AppImage.cancel,
                              width: 40,
                              color: AppColor.semiDarkGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      hintText: "Search",
                      title: "",
                      onChanged: (newValue) {},
                      prefixImagePath: AppImage.search,
                      fillColor: AppColor.greyColor,
                      showSpace: true,
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    ListView.separated(
                      itemCount: 6,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return Obx(
                          () => filledContainerWithRadio(
                            controller.purposeOfSurveyReportList[index],
                            controller.selectedSurveyReport.value,
                            controller.purposeOfSurveyReportList[index],
                            (newValue) {
                              controller.selectPurposeOfSurveyReport(newValue!);
                            },
                            controller.selectedSurveyReport ==
                                controller.purposeOfSurveyReportList[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.01,
                        );
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomButton(
                title: "Choose",
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
