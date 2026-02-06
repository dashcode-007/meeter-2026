import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/utils/pref_util.dart';

class BottomNavController extends GetxController {
  RxString currentRole = "".obs;
  Future<void> getCurrentRole() async {
     currentRole.value = await DbUtil.getRoleByUid();
  }

  RxInt currentIndex = 0.obs;

  void onIndexChange(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentRole();
  }
}
