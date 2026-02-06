import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/view/services/survey_screen..dart';
import 'package:sizer/sizer.dart';
import '../../../gen/assets.gen.dart';
import '../auth/Login/login_screen.dart';
import 'digital_wallet_screen.dart';
import 'eng_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.04;
    final gridSpacing = screenWidth * 0.04;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header (body-based, NOT AppBar)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -10, // 👈 lifted slightly
                      left: 0,
                      child: Image.asset(
                        Assets.images.group17.path,
                        width: 20.w,
                        height: 30.w,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        top: 15,
                        bottom: 4, // 👈 minimum space below title
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
                          SizedBox(width: screenWidth * 0.06),
                          const Text(
                            'Services',
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

                // Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Please choose the service that suits you',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.lightblackTxt
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: gridSpacing,
                            mainAxisSpacing: gridSpacing,
                            childAspectRatio: 1.2,
                            children: [
                              ServiceCard(
                                imagePath: Assets.images.icon82.path,
                                title: 'Survey Services',
                                onTap: () {
                                  Get.to(const SurveyScreen());
                                },
                              ),
                              ServiceCard(
                                imagePath: Assets.images.icon91.path,
                                title: 'Engineering',
                                onTap: () {
                                  Get.to(const EngineeringServicesScreen());
                                },
                              ),
                              ServiceCard(
                                imagePath: Assets.images.icon101.path,
                                title: 'Digital wallet',
                                onTap: () {
                                  Get.to(const DigitalWalletScreen());
                                },
                              ),
                              ServiceCard(
                                imagePath: Assets.images.icon111.path,
                                title: 'Engineering Consulting',
                                onTap: () {
                                  Get.to(const LoginScreen());

                                },
                              ),
                              ServiceCard(
                                imagePath: Assets.images.icon121.path,
                                title: 'Real Estate Consulting',
                                onTap: () {                                  Get.to(const LoginScreen());
                                },
                              ),
                              ServiceCard(
                                imagePath: Assets.images.icon131.path,
                                title: 'Meter Store',
                                onTap: () {                                  Get.to(const LoginScreen());
                                },
                              ),
                            ],
                          ),
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

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const ServiceCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final imageSize = screenWidth * 0.16;
    final cardPadding = screenWidth * 0.03;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: cardPadding,
            vertical: cardPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported_outlined,
                    size: imageSize,
                    color: const Color(0xFF5B6B7C),
                  );
                },
              ),
              SizedBox(height: screenWidth * 0.03),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                   fontFamily: AppFonts.artegraSoft,
                  color: AppColor.servicescreenTxt,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
