import 'package:get/get.dart';
import 'package:meter_app/routes/routes_name.dart';
import 'package:meter_app/view/auth/Signup/seller_login/face_auth.dart';
import 'package:meter_app/view/bottom_nav/bottom_nav_main.dart';
import 'package:meter_app/view/bottom_nav/home/seller_home/publish_device/publish_device1.dart';
import '../view/auth/Login/verification_screen.dart';
import '../view/auth/Signup/customer_login/customer_general_info.dart';
import '../view/auth/main_auth.dart';
import '../view/on_board/on_board.dart';
import '../view/splash/splash_screen.dart';

class Routes {
  static final routes = [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => const SplashScreen(),
    ),
    // GetPage(
    //   name: RoutesName.mainAuthScreen,
    //   page: () =>  MainAuth(),
    // ),
    GetPage(
      name: RoutesName.verificationScreen,
      page: () => const VerificationScreen(),
    ),
    GetPage(
      name: RoutesName.customerGeneralInfoScreen,
      page: () => const CustomerGeneralInfo(),
    ),
    GetPage(
      name: RoutesName.sellerFaceAuth,
      page: () => const SellerFaceAuth(),
    ),
    GetPage(
      name: RoutesName.bottomNavMain,
      page: () => const BottomNavMain(),
    ),
    GetPage(
      name: RoutesName.onBoard,
      page: () => const OnBoard(),
    ),
    GetPage(
      name: RoutesName.publishFirstDevice,
      page: () => const PublishFirstDevice(),
    ),
  ];
}
