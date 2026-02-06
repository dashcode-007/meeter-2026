import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/model/seller/device/device_model.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/widget/containers/back_button.dart';
import 'package:meter_app/widget/containers/circular_container.dart';
import 'package:meter_app/widget/text_widget.dart';

class StoreDetail extends StatelessWidget {
  final bool showChatIcon;
  final DeviceModel? deviceModel;
  const StoreDetail({super.key, this.showChatIcon = false, this.deviceModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(-Get.width / 2.4, 0),
                      child: const CustomBackButton(
                        backgroundColor: AppColor.whiteColor,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, -Get.height * 0.04),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(
                          deviceModel != null
                              ? deviceModel!.deviceImage
                              : "https://firebasestorage.googleapis.com/v0/b/application-92923.appspot.com/o/Profile%20Image%2F1719824324593?alt=media&token=98f92522-e00a-4242-896e-b7939caf8f5e",
                          height: Get.height * 0.25,
                          width: Get.width * 0.70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextWidget(
                    title: deviceModel != null
                        ? deviceModel!.deviceName
                        : "Electrical Machete",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: TextWidget(
                    title: "Device Specification",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 14),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                    title: deviceModel != null
                        ? deviceModel!.deviceModel
                        : "Device Specification would be here",
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextWidget(
                    textAlign: TextAlign.start,
                    title: deviceModel != null
                        ? deviceModel!.deviceDetails
                        : "Device Detail would be here that come from database",
                    textColor: AppColor.semiTransparentDarkGrey,
                    fontSize: 12),
              ),
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: TextWidget(
                    title: "Seller",
                    textColor: AppColor.semiDarkGrey,
                    fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Image.asset(
                      AppImage.person,
                      width: 40,
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    // FutureBuilder(
                    //   future: DbUtil.fetchAuthData(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Container();
                    //     } else if (snapshot.hasError) {
                    //       return Text('Error: ${snapshot.error}');
                    //     } else {
                    //       log("data is ${snapshot.data}");
                    //       String userName = snapshot.data![0].ownerName;
                    //       return TextWidget(
                    //           title: userName,
                    //           textColor: AppColor.semiDarkGrey,
                    //           fontSize: 14);
                    //     }
                    //   },
                    // ),
                    const Spacer(),
                    showChatIcon
                        ? CircularContainer(
                            onTap: () {},
                            imagePath: AppImage.chat,
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
