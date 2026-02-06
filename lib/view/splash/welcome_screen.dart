import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/utils/backend_util/constant_util.dart';
 import 'package:sizer/sizer.dart';
import '../../gen/assets.gen.dart';
import '../bottom_nav/home/home_screen.dart';
 class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Get.off(() => const HomeScreen(userType: ConstantUtil.customer,));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            Assets.images.bg.path,
            fit: BoxFit.cover,
          ),

          /// Main Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                /// Logo
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Image.asset(
                    Assets.images.logo.path,
                    width: 55.w,
                    height: 15.h,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 1.h),

                /// Tagline
                Text(
                  '#Makes_It_Easier_For_You',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),
                SizedBox(height: 10.h), // bottom spacing
              ],
            ),
          ),

          /// Bottom Loader (✅ correct usage)
          Positioned(
            bottom: 4.h,
            left: 0,
            right: 0,
            child: const Center(
              child: SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


