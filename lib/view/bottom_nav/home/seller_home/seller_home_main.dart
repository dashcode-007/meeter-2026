// Refactored SellerHomeMain with proper GetX architecture

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/bottom_nav_controller_main.dart';
import 'package:meter_app/controller/bottom_nav_controller/home_controller.dart';
import 'package:meter_app/controller/on_board_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/services/db_services.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/backend_util/date_time_util.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/utils/backend_util/query_util.dart';
import 'package:meter_app/view/bottom_nav/home/customer_home/request_a_service/request_service.dart';
import 'package:meter_app/view/bottom_nav/home/seller_home/publish_device/publish_device.dart';
import 'package:meter_app/view/bottom_nav/store/store_detail.dart';
import 'package:meter_app/widget/app_bar.dart';
import 'package:meter_app/widget/backend/custom_stream_builder.dart';
import 'package:meter_app/widget/categories_column.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/containers/edit_device_widget.dart';
import 'package:meter_app/widget/containers/request_container.dart';
import 'package:meter_app/widget/custom_loading.dart';
import 'package:meter_app/widget/services_controller.dart';
import 'package:meter_app/widget/success.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';
import 'package:meter_app/view/on_board/services/survey_report.dart';

class SellerHomeMain extends StatelessWidget {
  SellerHomeMain({super.key, required this.userType});

  final String userType;

  final HomeController controller = Get.put(HomeController(), permanent: true);
  final OnBoardController onBoardController = Get.put(OnBoardController());

  late final Future authFuture = DbUtil.fetchAuthData();

  @override
  Widget build(BuildContext context) {
    log("usertype on home is${userType}");
    return SafeArea(
      child: Scaffold(
        appBar: const CustomHomeAppBar(title: "Makka,Saudi Arabia"),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreeting(),
                const SizedBox(height: 12),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return FutureBuilder(
      future: authFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final userName = snapshot.data![0].ownerName;
        return RichText(
          text: TextSpan(
            style: AppTextStyle.dark20,
            children: [
              const TextSpan(text: 'Good Morning, '),
              TextSpan(
                text: userName,
                style: AppTextStyle.dark20.copyWith(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '!'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    switch (userType) {
      case ConstantUtil.seller:
        return SellerHomeView(controller: controller);
      case ConstantUtil.provider:
        return ProviderHomeView(controller: controller);
      default:
        return CustomerHomeView(
          controller: controller,
          onBoardController: onBoardController,
        );
    }
  }
}

// ---------------- SELLER ----------------
class SellerHomeView extends StatelessWidget {
  const SellerHomeView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const TextWidget(
          title: "Choose your service and start",
          textColor: AppColor.semiTransparentDarkGrey,
          fontSize: 16),
      SizedBox(
        height: Get.height * 0.05,
      ),
      MyCustomButton(
          iconPath: AppImage.service,
          textColor: AppColor.primaryColor,
          borderSideColor: AppColor.primaryColor,
          title: "Publish a device".tr,
          backgroundColor: Colors.transparent,
          onTap: () {
            Get.to(const PublishDevice(
              isUpdate: false,
            ));
          }),
      SizedBox(
        height: Get.height * 0.02,
      ),
      const TextWidget(
        title: "My Devices",
        fontWeight: FontWeight.bold,
        fontSize: 16,
        textColor: AppColor.semiDarkGrey,
      ),
      SizedBox(
        height: Get.height * 0.02,
      ),
      CustomStreamBuilder(
        stream: QueryUtil.fetchDevices(),
        builder: (context, devices) {
          log("Devices length is ${devices!.length}");
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
              itemCount: devices.length,
              itemBuilder: (itemBuilder, index) {
                final data = devices[index];
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
                            await DbServices.deleteDevice(
                                data.id);
                            Get.back();
                          }));
                    },
                    onEditTap: () {
                      Get.to(PublishDevice(
                        isUpdate: true,
                        deviceModel: data,
                      ));
                    },
                    imageUrl: data.deviceImage);
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
    ]);
  }
}

// ---------------- PROVIDER ----------------
class ProviderHomeView extends StatelessWidget {
  const ProviderHomeView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const TextWidget(
          title:
          "There are a lot of requests waiting for you",
          textColor: AppColor.semiTransparentDarkGrey,
          fontSize: 14),
      CustomTextField(
        controller: controller.searchController,
        hintText: "Search",
        title: "",
        showSpace: true,
        prefixImagePath: AppImage.search,
      ),
      SizedBox(
        height: Get.height * 0.03,
      ),
      const TextWidget(
        title: "Requests Near You",
        textColor: AppColor.semiDarkGrey,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        height: Get.height * 0.02,
      ),
      ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: 5,
        itemBuilder: (itemBuilder, index) {
          return const RequestContainer(
            buttonText: "Apply Now",
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: Get.height * 0.02,
          );
        },
      )
    ]);
  }
}

// ---------------- CUSTOMER ----------------
class CustomerHomeView extends StatelessWidget {
  const CustomerHomeView({super.key, required this.controller, required this.onBoardController});
  final HomeController controller;
  final OnBoardController onBoardController;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       const TextWidget(
          title: "Choose your service and start",
          textColor: AppColor.semiTransparentDarkGrey,
          fontSize: 16),
      SizedBox(
        height: Get.height * 0.04,
      ),
      MyCustomButton(
          iconPath: AppImage.service,
          textColor: AppColor.primaryColor,
          borderSideColor: AppColor.primaryColor,
          title: "Request a service".tr,
          backgroundColor: Colors.transparent,
          onTap: () {
            Get.to(const RequestService());
          }),
      SizedBox(
        height: Get.height * 0.03,
      ),
      const TextWidget(
        title: "Categories",
        textColor: AppColor.semiDarkGrey,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      SizedBox(
        height: Get.height * 0.19,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          padding: EdgeInsets.zero,
          itemBuilder: (itemBuilder, index) {
            return const CategoriesColumn(
                imagePath: AppImage.surveyOffices,
                title: "Survey Offices");
          },
          separatorBuilder:
              (BuildContext context, int index) {
            return SizedBox(
              width: Get.width * 0.03,
            );
          },
        ),
      ),
      const Row(
        children: [
          TextWidget(
            title: "Services",
            textColor: AppColor.semiDarkGrey,
            fontSize: 18,
          ),
          Spacer(),
          TextWidget(
            title: "See All",
            textColor: AppColor.primaryColor,
            fontSize: 14,
            showUnderline: true,
          )
        ],
      ),
      SizedBox(
        height: Get.height * 0.02,
      ),
      GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.08,
          ),
          itemCount: controller.imaPath.length,
          itemBuilder: (itemBuilder, index) {
            return ServicesColumn(
                onTap: (){
                  Get.to(SurveyReport(
                    title: onBoardController.title[index],
                    description:
                    onBoardController.description[index],
                    benefitList: onBoardController.benefitList[index],
                    imagePath: onBoardController.imagePath[index],
                  ));
                },
                title: controller.title[index],
                imagePath: controller.imaPath[index]);
          }),
      SizedBox(
        height: Get.height * 0.02,
      ),
      Row(
        children: [
          const TextWidget(
              title: "Explore Products",
              textColor: AppColor.semiDarkGrey,
              fontSize: 18),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.find<BottomNavController>()
                  .onIndexChange(1);
            },
            child: const TextWidget(
                title: "See All",
                textColor: AppColor.primaryColor,
                showUnderline: true,
                fontSize: 17),
          ),
        ],
      ),
      SizedBox(
        height: Get.height * 0.03,
      ),
      GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.7,
          ),
          itemCount: 10,
          itemBuilder: (itemBuilder, index) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius:
                      BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Image.asset(
                        AppImage.productImage,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const TextWidget(
                        title: "Electrical Machine",
                        textColor: AppColor.semiDarkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      const Row(
                        children: [
                          TextWidget(
                            title: "3.4",
                            textColor:
                            AppColor.semiDarkGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                          Spacer(),
                          TextWidget(
                              title: "302 SAR",
                              textColor:
                              AppColor.primaryColor,
                              fontSize: 14)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: const TextWidget(
                    textColor: AppColor.whiteColor,
                    title: "25 %",
                    fontSize: 14,
                  ),
                ),
              ],
            );
          }),
    ]);
  }
}
