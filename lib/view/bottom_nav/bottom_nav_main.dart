// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:meter_app/controller/bottom_nav_controller/bottom_nav_controller_main.dart';
// import 'package:meter_app/res/app_color/app_color.dart';
// import 'package:meter_app/res/app_assets/app_image.dart';
// import 'package:meter_app/utils/backend_util/constant_util.dart';
// import 'package:meter_app/view/bottom_nav/account/account_main.dart';
// import 'package:meter_app/view/bottom_nav/chat/chat_main.dart';
// import 'package:meter_app/view/bottom_nav/home/seller_home/devices.dart';
// import 'package:meter_app/view/bottom_nav/home/seller_home/seller_home_main.dart';
//  import 'package:meter_app/view/bottom_nav/store/store_main.dart';
//
// class BottomNavMain extends StatelessWidget {
//   final String? userType;
//   const BottomNavMain({super.key, this.userType});
//
//   @override
//   Widget build(BuildContext context) {
//     final BottomNavController bottomNavController =
//         Get.put(BottomNavController());
//     return SafeArea(
//         child: Scaffold(
//       body: Obx(() {
//          bool isSeller = userType == ConstantUtil.seller;
//         log("why role is $userType");
//         List<Widget> children = [
//             SellerHomeMain(userType: userType ?? ConstantUtil.customer,),
//           if (!isSeller) const StoreMain(),
//           if (isSeller) const AllDevices(),
//           // if (!isSeller) const RequestsMain(),
//           const ChatMain(),
//            // AccountMain(),
//         ];
//
//         return children[bottomNavController.currentIndex.value];
//       }),
//       bottomNavigationBar: Obx(() {
//         bool isSeller = userType == ConstantUtil.seller;
//         bool isProvider = userType == ConstantUtil.provider;
//
//         List<BottomNavigationBarItem> items = [
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               AppImage.home,
//               width: 22,
//               height: 22,
//             ),
//             activeIcon: Image.asset(
//               AppImage.homeActive,
//               width: 24,
//               height: 24,
//             ),
//             label: "Home".tr,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               AppImage.store,
//               width: 22,
//               height: 22,
//             ),
//             activeIcon: Image.asset(
//               AppImage.storeActive,
//               width: 24,
//               height: 24,
//             ),
//             label: !isSeller ? "Store".tr : "My devices",
//           ),
//           if (!isSeller)
//             BottomNavigationBarItem(
//               icon: Image.asset(
//                 AppImage.requests,
//                 width: 22,
//                 height: 22,
//               ),
//               activeIcon: Image.asset(
//                 AppImage.requestsActive,
//                 width: 24,
//                 height: 24,
//               ),
//               label: isProvider ? "Proposals".tr : "Requests".tr,
//             ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               AppImage.chat,
//               width: 22,
//               height: 22,
//             ),
//             activeIcon: Image.asset(
//               AppImage.chatActive,
//               width: 24,
//               height: 24,
//             ),
//             label: "Chat".tr,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               AppImage.account,
//               width: 22,
//               height: 22,
//             ),
//             activeIcon: Image.asset(
//               AppImage.accountActive,
//               width: 24,
//               height: 24,
//             ),
//             label: "Account".tr,
//           ),
//         ];
//
//         return BottomNavigationBar(
//           elevation: 0,
//           items: items,
//           showUnselectedLabels: true,
//           backgroundColor: Colors.transparent,
//           // selectedFontSize: 10,
//           currentIndex: bottomNavController.currentIndex.value,
//           selectedItemColor: AppColor.primaryColor,
//           unselectedItemColor: AppColor.semiTransparentDarkGrey,
//           iconSize: 18,
//           selectedLabelStyle: GoogleFonts.poppins(
//             fontSize: 12.0,
//             fontWeight: FontWeight.w500,
//           ),
//           onTap: (index) {
//             bottomNavController.onIndexChange(index);
//           },
//         );
//       }),
//     ));
//   }
// }
