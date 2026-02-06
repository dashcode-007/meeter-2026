import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../res/app_color/app_color.dart';
import '../../../res/app_fonts/app_fonts.dart';

class DeviceProductCardNew extends StatelessWidget {
  final String name;
  final String imagePath;
  final double rating;
  final VoidCallback? onTap;

  const DeviceProductCardNew({
    super.key,
    required this.name,
    required this.imagePath,
    required this.rating,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            /// Cart Icon
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.orange,
                  size: 20.sp,
                ),
              ),
            ),

            /// Product Image (centered)
            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  height: 85,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 1.h),

            /// Product Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.lightblackTxt,
                  fontFamily: AppFonts.artegraSoft,
                  height: 1.3,
                ),
              ),
            ),

            SizedBox(height: 0.6.h),

            /// Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColor.lightblackTxt,
                    fontFamily: AppFonts.artegraSoft,
                  ),
                ),
                SizedBox(width: 1.w),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
              ],
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
