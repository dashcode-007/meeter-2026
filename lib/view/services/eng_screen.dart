import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:meter_app/view/services/topographic_survey_screen.dart';
import 'package:sizer/sizer.dart';

class EngineeringServicesScreen extends StatelessWidget {
  const EngineeringServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      top: -10, // 👈 slightly lifted
                      left: 0,
                      child: Image.asset(
                        'assets/images/Group 17.png',
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
                        left: 4.w,
                        right: 4.w,
                        top: 2.h,
                        bottom: 0.5.h, // 👈 minimum space below text
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
                            'Engineering',
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
                    padding: EdgeInsets.all(4.w),
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
                        SizedBox(height: 2.5.h),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 3.w,
                            crossAxisSpacing: 3.w,
                            childAspectRatio: 0.86,
                            children: [
                              _buildServiceCard('Building\nLicenses', 'assets/images/Icon 28 1.png'),
                              _buildServiceCard('Building\nCompliance...', 'assets/images/icon 29 1.png'),
                              _buildServiceCard('Technical\nReport', 'assets/images/icon 30 1.png'),
                              _buildServiceCard('Excavation\nMarking', 'assets/images/icon 31 1.png'),
                              _buildServiceCard('Building\nLevel Deter...', 'assets/images/icon 32 1.png'),
                              _buildServiceCard('Quantity\nSurveying agency', 'assets/images/icon 33 1.png'),
                              _buildServiceCard('Construction\nSurveying agency.', 'assets/images/icon 34 1.png'),
                              _buildServiceCard('Point Setting\nOut', 'assets/images/icon 35 1.png'),
                              _buildServiceCard('Construction\nCompletion...', 'assets/images/icon 36 1.png'),
                              _buildServiceCard('Building\nConformity ...', 'assets/images/icon 37 1.png'),
                              _buildServiceCard('Safety Works', 'assets/images/icon 38 1.png'),
                              _buildServiceCard('Demolition\nPermit', 'assets/images/icon 39 1.png'),
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

  Widget _buildServiceCard(String title, String imagePath) {
    return GestureDetector(
      onTap: (){
        Get.to(TopographicSurveyScreen(name: title,));
      },

      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 2.5.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                flex: 3,
                child: Image.asset(
                  imagePath,
                  width: 20.w,
                  height: 20.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_outlined,
                      size: 15.w,
                      color: Colors.grey[400],
                    );
                  },
                ),
              ),
              SizedBox(height: 1.5.w),
              Flexible(
                flex: 2,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                     fontFamily: AppFonts.artegraSoft,
                    color: AppColor.surveycreenTxt,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
