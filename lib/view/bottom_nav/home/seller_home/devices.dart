import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/seller_controller/device_controller.dart';
import 'package:meter_app/controller/bottom_nav_controller/store_controller/store_controller.dart';
import 'package:meter_app/model/seller/device/device_model.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/services/db_services.dart';
import 'package:meter_app/utils/backend_util/date_time_util.dart';
import 'package:meter_app/utils/backend_util/query_util.dart';
import 'package:meter_app/view/bottom_nav/home/seller_home/publish_device/publish_device.dart';
import 'package:meter_app/view/bottom_nav/store/store_detail.dart';
import 'package:meter_app/widget/backend/custom_stream_builder.dart';

import 'package:meter_app/widget/containers/edit_device_widget.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class AllDevices extends StatelessWidget {
  const AllDevices({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DeviceController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: TextWidget(
                      title: "My Devices",
                      textColor: AppColor.semiDarkGrey,
                      fontSize: 16),
                ),
                CustomTextField(
                    prefixImagePath: AppImage.search,
                    hintText: "Search",
                    title: "",
                    onChanged: (newValue) {
                      controller.onChangeSearch(newValue);
                      log("New Value is $newValue");
                    },
                    controller: controller.searchController),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomStreamBuilder(
                  stream: QueryUtil.fetchDevices(),
                  builder: (context, devices) {
                    return Obx(() {
                      List<DeviceModel> filteredDevices = [];
                      if (controller.deviceSearch.value.isEmpty ||
                          controller.deviceSearch.value == "") {
                        filteredDevices = devices!;
                      } else {
                        final lowerCaseSearch =
                            controller.deviceSearch.value.toLowerCase();

                        filteredDevices = devices!.where((device) {
                          final lowerCaseDeviceName =
                              device.deviceName.toLowerCase();
                          final lowerCaseModel =
                              device.deviceModel.toLowerCase();
                          int relevanceScore = 0;

                          // Condition 1: Exact match
                          if (lowerCaseDeviceName == lowerCaseSearch) {
                            relevanceScore +=
                                3; // Assign a higher score for an exact match
                          }

                          // Condition 2: Contains the search term
                          if (lowerCaseDeviceName.contains(lowerCaseSearch) ||
                              lowerCaseModel.contains(lowerCaseSearch)) {
                            relevanceScore +=
                                1; // Assign a lower score for partial match
                          }

                          return relevanceScore > 0;
                        }).toList();
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.4,
                        ),
                        itemCount: filteredDevices.length,
                        itemBuilder: (context, index) {
                          final data = filteredDevices[index];

                          return EditDeviceWidget(
                            date: DateTimeUtil.reformatDate(
                                data.timestamp.toString()),
                            onClick: () {
                              Get.to(StoreDetail(
                                showChatIcon: false,
                                deviceModel: data,
                              ));
                            },
                            deviceName: data.deviceName,
                            deviceModel: data.deviceModel,
                            onDeleteTap: () {
                              Get.dialog(LogoutDialogue(
                                title: "Delete Device",
                                description:
                                    "Are you sure you want to delete device?",
                                mainButtonText: "Delete",
                                mainButtonTap: () async {
                                  await DbServices.deleteDevice(data.id);
                                  Get.back();
                                },
                              ));
                            },
                            onEditTap: () {
                              Get.to(PublishDevice(
                                isUpdate: true,
                                deviceModel: data,
                              ));
                            },
                            imageUrl: data.deviceImage,
                          );
                        },
                      );
                    });
                  },
                  loadingWidget: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.2,
                      ),
                      const CustomLoading(),
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
