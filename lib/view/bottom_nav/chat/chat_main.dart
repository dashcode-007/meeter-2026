import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/controller/bottom_nav_controller/chat_controller/chat_controller_main.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/app_textstyle.dart';
import 'package:meter_app/view/bottom_nav/chat/chat_detail.dart';
import 'package:meter_app/widget/text_widget.dart';
import 'package:meter_app/widget/textfield.dart';

class ChatMain extends StatelessWidget {
  const ChatMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatControllerMain());
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const TextWidget(
                    title: "Message",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextField(
                      controller: controller.searchController,
                      prefixImagePath: AppImage.search,
                      hintText: "Search".tr,
                      title: ""),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  ListView.builder(
                      itemCount: 12,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (itemBuilder, index) {
                        return Transform.translate(
                          offset: const Offset(-18, 0),
                          child: ListTile(
                            onTap: () {
                              Get.to(const ChatDetail());
                            },
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppImage.profile),
                            ),
                            trailing: const TextWidget(
                                title: "10:25",
                                textColor: AppColor.semiTransparentDarkGrey,
                                fontSize: 11),
                            title: const TextWidget(
                                textAlign: TextAlign.left,
                                title: "Name",
                                textColor: AppColor.semiDarkGrey,
                                fontSize: 14),
                            subtitle: const TextWidget(
                              textAlign: TextAlign.left,
                              title: "Message would be here okk",
                              textColor: AppColor.semiTransparentDarkGrey,
                              fontSize: 12,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          )),
    );
  }
}
