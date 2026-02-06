import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/view/requests/request_detail.dart';
import 'package:meter_app/view/requests/request_info.dart';
import 'package:meter_app/widget/avatar_list.dart';
import 'package:meter_app/widget/containers/button.dart';
import 'package:meter_app/widget/text_widget.dart';

import '../../res/app_assets/app_image.dart';

class CustomerRequestsContainer extends StatelessWidget {
  final String status;
  final List<String>? imagePath;
  final String? imageLabel;
  final bool showAvatar;
  const CustomerRequestsContainer(
      {super.key,
      required this.status,
      this.imagePath,
      this.imageLabel,
      this.showAvatar = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == "Completed") {
          Get.to(RequestDetail());
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColor.lightGreyShade),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                children: [
                  const TextWidget(
                      title: "Survey Report",
                      textColor: AppColor.primaryColor,
                      fontSize: 14),
                  const Spacer(),
                  TextWidget(
                      title: status,
                      textColor: status == "2m"
                          ? AppColor.primaryColor
                          : status == "Active"
                              ? AppColor.greenColor
                              : AppColor.semiDarkGrey,
                      fontSize: 12)
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColor.primaryColor,
                    backgroundImage: AssetImage(AppImage.dummySketch),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        title: "Construction Estimation",
                        textColor: AppColor.semiDarkGrey,
                        fontSize: 18,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppImage.activeLocation,
                            width: 18,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const TextWidget(
                            textColor: AppColor.semiTransparentDarkGrey,
                            fontSize: 14,
                            title: "Makka,Saudi Arabia",
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const TextWidget(
                title:
                    "Lorem ipsum dolor sit amet consectetur. Dignissim tortor dictum justo lorem suspendisse turpis integer eu. Elementum commodo ultrices sodales sed leo. Sed elit quis nisi laoreet mauris bibendum..",
                textColor: AppColor.semiTransparentDarkGrey,
                fontSize: 12,
                textAlign: TextAlign.start,
              ),
              if (showAvatar) ...[
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    AvatarList(imagePaths: imagePath!),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    TextWidget(
                        title: imageLabel!,
                        textColor: AppColor.semiTransparentDarkGrey,
                        fontSize: 12),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                status == "2m"
                    ? MyCustomButton(
                        padding: 12,
                        title: "View All Proposal",
                        onTap: () {
                          Get.to(const RequestInfo());
                        },
                        borderSideColor: AppColor.primaryColor,
                        textColor: AppColor.primaryColor,useGradient: false,
                        backgroundColor: AppColor.lightGreyShade,
                      )
                    : Container()
              ]
            ],
          ),
        ),
      ),
    );
  }
}
