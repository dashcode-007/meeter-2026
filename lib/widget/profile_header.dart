

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/widget/containers/circular_container.dart';
import 'package:meter_app/widget/text_widget.dart';

import '../utils/backend_util/dbutil.dart';
import '../view/account/edit_user_info.dart';

class ProfileHeader extends StatelessWidget {
  final bool showPersonalInfo;
  final String name;
  const ProfileHeader({super.key, this.showPersonalInfo = true, required this.name});

  @override
  Widget build(BuildContext context) {
    log("message $name");
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: const CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage(AppImage.profile),
          ),
        ),
        // FutureBuilder(
        //   future: DbUtil.fetchAuthData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Container();
        //     } else if (snapshot.hasError) {
        //       return Text('Error: ${snapshot.error}');
        //     } else {
        //       log("data is ${snapshot.data}");
        //       String userName = snapshot.data![0].ownerName;
        //       String email = snapshot.data![0].email;
        //       String phone = snapshot.data![0].phoneNumber;
        //       return  Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Transform.translate(
        //             offset: Offset(showPersonalInfo ? -Get.width * 0.00 : 3, 0),
        //             child: TextWidget(
        //               textAlign: TextAlign.start,
        //               title: userName,
        //               textColor: AppColor.primaryColor,
        //             ),),
        //           const SizedBox(
        //             height: 2,
        //           ),
        //           showPersonalInfo
        //               ? Transform.translate(
        //             offset: Offset(-Get.width * 0.06, 0),
        //             child: twoWidget(
        //                 imagePath: AppImage.call, text: phone),
        //           )
        //               : Container(),
        //           showPersonalInfo
        //               ? twoWidget(
        //               imagePath: AppImage.mail, text: email)
        //               : Container(),
        //         ],
        //       );
        //     }
        //   },
        // ),

        const Spacer(),
        CircularContainer(
            imageSize: 24,
            imagePath: AppImage.pen,
            onTap: () {
              Get.bottomSheet(
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  const EditUserInfo(),
                  backgroundColor: AppColor.whiteColor);
            })
      ],
    );
  }

  Widget twoWidget({required imagePath, required text}) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        TextWidget(title: text, textColor: AppColor.semiDarkGrey, fontSize: 12)
      ],
    );
  }
}
