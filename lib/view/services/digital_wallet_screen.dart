import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/view/auth/Login/login_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../gen/assets.gen.dart';

class DigitalWalletScreen extends StatelessWidget {
  const DigitalWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                 Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -10,
                      left: 0,
                      child: Image.asset(
                        Assets.images.group17.path,
                        width: 25.w,
                        height: 25.w,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 4.w,
                        right: 4.w,
                        top: 2.h,
                        bottom: 3.h,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 31,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 22,
                              ),
                              onPressed: () => Navigator.pop(context),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          const Text(
                            'Digital Wallet',
                            style: TextStyle(
                               color: AppColor.lightblackTxt,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:8.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: WalletCard(
                                label: 'Deeds',
                                imagePath: Assets.images.icon412.path,
                                onTap: () {

                                  Get.to(const LoginScreen());
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: WalletCard(
                                label: 'Building Permits',
                                imagePath: Assets.images.icon421.path,
                                onTap: () {
                                  Get.to(const LoginScreen());

                                  print('Building Permits tapped');
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.w),
                        Row(
                          children: [
                            Expanded(
                              child: WalletCard(
                                label: 'Survey Decisions',
                                imagePath: Assets.images.icon412.path,
                                onTap: () {
                                  Get.to(LoginScreen());

                                  print('Survey Decisions tapped');
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: WalletCard(
                                label: 'Plans',
                                imagePath: Assets.images.icon421.path,
                                onTap: () {
                                  Get.to(LoginScreen());

                                  print('Plans tapped');
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.w),
                        Row(
                          children: [
                            Expanded(
                              child: WalletCard(
                                label: 'Maps and Spatial Information',
                                imagePath: Assets.images.icon412.path,
                                onTap: () {
                                  Get.to(LoginScreen());

                                  print('Maps and Spatial Information tapped');
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback? onTap;

  const WalletCard({
    Key? key,
    required this.label,
    required this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported_outlined,
                      size: 18.w,
                      color: Colors.grey[400],
                    );
                  },
                ),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                  fontWeight: FontWeight.w500,
                   fontFamily: AppFonts.artegraSoft,
                  color: AppColor.servicescreenTxt,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
