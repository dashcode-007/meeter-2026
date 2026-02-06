import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/bottom_nav_controller_main.dart';
import 'package:meter_app/controller/bottom_nav_controller/provider_controller/proposal_controller.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
import 'package:meter_app/widget/containers/customer_requests_container.dart';
import 'package:meter_app/widget/containers/proposal_container.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class RequestsMainNew extends StatelessWidget {
  final String userType;
  const RequestsMainNew({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProposalController());
    final bottomController = Get.find<BottomNavController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: TextWidget(
                  title: "Requests",
                  textColor: AppColor.semiDarkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextField(
                controller: controller.searchController,
                hintText: "Search",
                title: "",
                prefixImagePath: AppImage.search,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  itemCount: controller.helpList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (itemBuilder, index) {
                    return Obx(() => GestureDetector(
                          onTap: () {
                            controller.onChangeSelectedIndex(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: controller.selectedIndex.value == index
                                    ? AppColor.primaryColor
                                    : AppColor.lightGreyShade),
                            child: Center(
                                child: TextWidget(
                                    title: controller.helpList[index]
                                        .toString()
                                        .tr,
                                    textColor:
                                        controller.selectedIndex.value == index
                                            ? AppColor.whiteColor
                                            : AppColor.semiDarkGrey,
                                    fontSize: 14)),
                          ),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              if (userType == ConstantUtil.provider) ...[
                Obx(() {
                  if (controller.selectedIndex.value == 0) {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return const ProposalContainer(
                          status: "New",
                          imagePath: [
                            AppImage.profile,
                            AppImage.profile,
                            AppImage.profile
                          ],
                          imageLabel: '+10 Proposals',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    );
                  } else if (controller.selectedIndex.value == 1) {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return const ProposalContainer(
                          status: "Active",
                          imagePath: [
                            AppImage.profile,
                          ],
                          imageLabel: 'EltWhid Software Engineering',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    );
                  } else {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return const ProposalContainer(
                          status: "Completed",
                          imagePath: [AppImage.profile],
                          imageLabel: "EltWhid Software Engineering",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    );
                  }
                }),
              ],
              if (userType == ConstantUtil.customer) ...[
                Obx(() {
                  if (controller.selectedIndex.value == 0) {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return const CustomerRequestsContainer(
                          status: "2m",
                          imagePath: [
                            AppImage.profile,
                            AppImage.profile,
                            AppImage.profile
                          ],
                          imageLabel: '+10 Proposals',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    );
                  } else if (controller.selectedIndex.value == 1) {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return const CustomerRequestsContainer(
                          status: "Active",
                          imagePath: [
                            AppImage.profile,
                          ],
                          imageLabel: 'EltWhid Software Engineering',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    );
                  } else {
                    return ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return const CustomerRequestsContainer(
                          status: "Completed",
                          imagePath: [AppImage.profile],
                          imageLabel: "EltWhid Software Engineering",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: Get.height * 0.03,
                        );
                      },
                    );
                  }
                }),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
