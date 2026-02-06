import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/gen/assets.gen.dart';
import 'package:meter_app/view/bottom_nav/home/seller_home/components/hafiz.dart';
import 'package:sizer/sizer.dart';


class SurveyScreen extends StatelessWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.09;
    final gridSpacing = screenWidth * 0.03;
    final cardAspectRatio = 0.80;

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
                        bottom: 4, // 👈 minimum space below text
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
                            'Survey',
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

                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
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
                        SizedBox(height: screenHeight * 0.025),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: gridSpacing,
                          mainAxisSpacing: gridSpacing,
                          childAspectRatio: cardAspectRatio,
                          children:
                          [
                            GestureDetector(


                                child: ServiceCard(imagePath: Assets.images.icon141.path, title: 'Survey Report',
                                onTap: (){
                                  Get.to(TopographicSurveyScreen());
                                },
                                )),
                            ServiceCard(imagePath: Assets.images.icon151.path, title: 'Topographic Survey'),
                            ServiceCard(imagePath: Assets.images.icon161.path, title: 'Survey Works'),
                            ServiceCard(imagePath: Assets.images.icon181.path, title: 'Survey Decision'),
                            ServiceCard(imagePath: Assets.images.icon171.path, title: 'Land Coordinates ...'),
                            ServiceCard(imagePath: Assets.images.icon191.path, title: 'Land Subdivision'),
                            ServiceCard(imagePath: Assets.images.icon211.path, title: 'Grid Leveling'),
                            ServiceCard(imagePath: Assets.images.icon201.path, title: 'Contour Maps'),
                            ServiceCard(imagePath: Assets.images.icon221.path, title: 'Survey Report Preparation'),
                            ServiceCard(imagePath: Assets.images.icon231.path, title: 'Land Staking'),
                            ServiceCard(imagePath: Assets.images.icon241.path, title: 'Land Boundary Services'),
                            ServiceCard(imagePath: Assets.images.icon251.path, title: 'Land Ownership Preperation'),
                            ServiceCard(imagePath: Assets.images.icon261.path, title: 'Land Merging'),
                            ServiceCard(imagePath: Assets.images.icon271.path, title: 'Real Estate Unit Partitio...'),
                            ServiceCard(imagePath: Assets.images.icon411.path, title: 'Farm Partitioning'),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
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
  final VoidCallback? onTap;

  const ServiceCard({
    Key? key,
    required this.imagePath,
    required this.title,
      this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print('Selected: $title');
              Get.to(TopographicSurveyScreen(
                name: title,
              ));

            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenWidth * 0.025,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 3,
                    child: Image.asset(
                      imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.015),
                  Flexible(
                    flex: 2,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                         fontFamily: AppFonts.artegraSoft,
                        color: AppColor.surveycreenTxt,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
