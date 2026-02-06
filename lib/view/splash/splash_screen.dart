import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:meter_app/controller/bottom_nav_controller/bottom_nav_controller_main.dart';
import 'package:meter_app/controller/translation_controller.dart';
import 'package:meter_app/res/app_assets/app_image.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/routes/routes_name.dart';
import 'package:meter_app/utils/backend_util/auth_util.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
import 'package:meter_app/utils/backend_util/dbutil.dart';
import 'package:meter_app/utils/pref_util.dart';
import 'dart:developer';
import 'package:meter_app/view/on_board/on_board.dart';

import '../bottom_nav/account/select_country_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      final String? currentLocale = Get.locale?.toString();
      bool? isEnglish = PrefUtil.getBool(PrefUtil.language);

      if (isEnglish == null) {
        if (currentLocale == null || currentLocale == "en_US") {
          PrefUtil.setBool(PrefUtil.language, true);
        } else {
          PrefUtil.setBool(PrefUtil.language, false);
        }
      } else {
        if (isEnglish) {
          ChangeLanguageController.changeLanguage("en", "US");
        } else {
          ChangeLanguageController.changeLanguage("ar", "Ar");
        }
      }

      navigate();
    });
  }

  void navigate() {
    final auth = DbUtil.getCurrentUid();
    log("Auth is----> $auth");

    if (auth != "" && auth != null) {
      Get.offAllNamed(RoutesName.bottomNavMain);
    } else {
      Get.off(const SelectCountryScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: Get.height,
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     Color(0xFFF5A962),
          //     Color(0xFFEB8C4A),
          //   ],
          // ),
            image: DecorationImage(image: AssetImage("assets/images/splash_bg.png",))
        ),
        child: Stack(
          children: [
            /// Center Logo + Text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImage.meter,
                    width: Get.width * 0.5,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 24),

                  /// Updated Text Style (Inter – 40px – Bold)
                  //   Text(
                  //   'منصة متر',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontFamily: 'Inter',
                  //     fontWeight: FontWeight.w700,
                  //     fontSize: 40.px,
                  //     height: 1.0,
                  //     letterSpacing: 0,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/arbi.svg',
                      width: Get.width * 0.35,

                      //  width: double.infinity,
                      // fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            /// Bottom Image (instead of animation)
            Positioned(
              bottom: Get.height * 0.06,
              left: 0,
              right: 0,
              child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

