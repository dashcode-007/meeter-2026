import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/customer_controller/request_service_controler.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/utils/short_message_utils.dart';
import 'package:meter_app/utils/validation_utils.dart';
import 'package:meter_app/view/bottom_nav/home/customer_home/request_a_service/request_service/request_service2.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/group_radio_button.dart';
import 'package:meter_app/widget/header.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class RequestFirstService extends StatelessWidget {
  const RequestFirstService({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RequestServiceController>();
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: Container(
          height: Get.height * 0.08,
          margin:
              EdgeInsets.only(bottom: Get.height * 0.02, left: 14, right: 14),
          child: Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: CustomButton(
                  title: "Continue",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(const RequestSecondService());
                    } else {
                      ShortMessageUtils.showError("Please fill all fields");
                    }
                  }))),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CustomHeader(
                title: "Request a service",
                showProgress: true,
                progressWidth: 1.7,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                              validator:
                                  ValidationUtils.validateRequired("Region"),
                              hintText: "Enter Region",
                              title: "Region",
                              controller: controller.regionController),
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Expanded(
                          child: CustomTextField(
                              richText: "(Optional)",
                              hintText: "Enter City",
                              title: "City",
                              controller: controller.cityController),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                        hintText: "Enter neighborhood",
                        title: "Neighborhood",
                        richText: "(Optional)",
                        controller: controller.neighborhoodController),
                    CustomTextField(
                        validator: ValidationUtils.validateRequired("Location"),
                        hintText: "Location",
                        title: "Location",
                        controller: controller.locationController),
                    CustomTextField(
                      validator:
                          ValidationUtils.validateRequired("Piece Number"),
                      hintText: "Enter Piece Number",
                      title: "Piece Number",
                      controller: controller.pieceNumberController,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                      hintText: "Enter chart number",
                      title: "Chart Number",
                      controller: controller.chartNumberController,
                      textInputType: TextInputType.number,
                      richText: "(Optional)",
                    ),
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
    ));
  }
}
