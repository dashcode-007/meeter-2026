import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:sizer/sizer.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Custom Top Section (replacing AppBar)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  // Back Arrow in Container
                  Container(
                    padding: EdgeInsets.all(2.5.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 18.sp,
                    ),
                  ),
                  
                  SizedBox(width: 18.w),
                  
                  // Logo Image (replace with your logo path)
                  Image.asset(
                    'assets/images/meter.webp', // Change this to your logo path
                    height: 60, // Adjust height as needed
                    fit: BoxFit.contain,
                  ),
                  
                  const Spacer(),
                  
                  // Cart Icon
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.orange,
                    size: 20.sp,
                  ),
                ],
              ),
            ),

            // 🔍 Search Bar
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                  color: AppColor.searchcolor
                ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Find the product you want',
                    hintStyle:  const TextStyle(
                           color: AppColor.searchcolor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFonts.artegraSoft
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.searchcolor,
                      size: 25,
                    ),
                    suffixIcon: Icon(
                      Icons.tune,
                      color: Colors.orange,
                      size: 22.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.8.h,
                    ),
                  ),
                ),
              ),
            ),

            // Products Grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _buildProductCard(index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final products = [
      {
        'name': 'Leica Level NA720',
        'image': 'assets/images/image 8.png',
        'rating': 4.5,
      },
      {
        'name': 'Leica Total Station TS07\n1" R500',
        'image': 'assets/images/image 9.png',
        'rating': 4.5,
      },
      {
        'name': 'WingtraOne',
        'image': 'assets/images/image 10.png',
        'rating': 4.5,
      },
      {
        'name': 'Leica Blk360 Scanner',
        'image': 'assets/images/image 11.png',
        'rating': 4.5,
      },
      {
        'name': 'Leica Pegasus TRK',
        'image': 'assets/images/image 12.png',
        'rating': 4.5,
      },
      {
        'name': 'TOPCON GTS09 Robotic',
        'image': 'assets/images/image 12.png',
        'rating': 4.5,
      },
    ];

    final product = products[index];

    return Container(
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
          // Cart Icon
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

          // 🖼️ Product Image (PERFECTLY CENTERED)
          Expanded(
            child: Center(
              child: Image.asset(
                product['image'] as String,
                height: 85,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Product Name
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Text(
              product['name'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColor.lightblackTxt,
                fontFamily: AppFonts.artegraSoft,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(height: 0.6.h),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${product['rating']}',
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
    );
  }
}