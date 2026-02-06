import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/bottom_nav_controller/bottom_nav_controller_main.dart';
import '../../res/app_assets/app_image.dart';
import '../../res/app_color/app_color.dart';
import '../../utils/backend_util/constant_util.dart';
  import '../account/account_main.dart';
import '../chat/chat_main.dart';
import '../device_screen/device_screen_new.dart';
import '../requests/requests_main.dart';
import 'home_screen.dart';

class BottomNavScreenNew extends StatefulWidget {
  final String? userType;
  const BottomNavScreenNew({super.key, this.userType});

  @override
  State<BottomNavScreenNew> createState() => _BottomNavScreenNew();
}

class _BottomNavScreenNew extends State<BottomNavScreenNew> {
  late final List<Widget> _screens = [
    HomeScreen(
      userType: widget.userType,
    ),
    DevicesScreen(),
      RequestsMainNew(userType: widget.userType.toString(),),
    ChatMain(),
    AccountMain(
      userType: widget.userType.toString(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
    Get.put(BottomNavController());

    return Obx(() {
      bool isSeller = widget.userType == ConstantUtil.seller;
      bool isProvider = widget.userType == ConstantUtil.provider;

      List<BottomNavigationBarItem> items = [
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.home,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.homeActive,
            width: 24,
            height: 24,
          ),
          label: "Home".tr,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.store,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.storeActive,
            width: 24,
            height: 24,
          ),
          label: !isSeller ? "Store".tr : "My devices",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.requests,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.requestsActive,
            width: 24,
            height: 24,
          ),
          label: isProvider ? "Proposals".tr : "Requests".tr,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.chat,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.chatActive,
            width: 24,
            height: 24,
          ),
          label: "Chat".tr,
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            AppImage.account,
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            AppImage.accountActive,
            width: 24,
            height: 24,
          ),
          label: "Account".tr,
        ),
      ];

      return Scaffold(
        body: _screens[bottomNavController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          items: items,
          showUnselectedLabels: true,
          backgroundColor: Colors.transparent,
          currentIndex: bottomNavController.currentIndex.value,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.semiTransparentDarkGrey,
          iconSize: 18,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) {
            bottomNavController.onIndexChange(index);
          },
        ),
      );
    });
  }
}
