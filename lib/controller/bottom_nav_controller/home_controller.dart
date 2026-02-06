import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/utils/db_utils.dart';
import 'package:meter_app/utils/pref_util.dart';

import '../../utils/backend_util/dbutil.dart';

class HomeController extends GetxController {
  RxString currentRole = "".obs;
  Future<void> getCurrentRole() async {
    // currentRole.value = PrefUtil.getString(PrefUtil.role);

    currentRole.value = await DbUtil.getRoleByUid();
  }

  final TextEditingController searchController = TextEditingController();
  List imaPath = [
    AppImage.surveyReport,
    AppImage.completionCertificate,
    AppImage.accupancyCertificate,
    AppImage.designWork
  ];

  List title = [
    "Survey Reports",
    "Building Completion Certificate",
    "Occupancy Certificate",
    "Design Work"
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentRole();
  }
}
