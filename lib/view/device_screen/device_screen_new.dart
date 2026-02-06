import 'package:flutter/material.dart';
import 'package:meter_app/res/app_color/app_color.dart';
import 'package:meter_app/res/app_fonts/app_fonts.dart';
import 'package:sizer/sizer.dart';

import 'components/device_product_card.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> products = const [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
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
                  
                   Image.asset(
                    'assets/images/meter.webp',
                    height: 60,
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

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.w,
                    mainAxisSpacing: 2.h,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return DeviceProductCardNew(
                      name: product['name'],
                      imagePath: product['image'],
                      rating: product['rating'],
                      onTap: () {
                        print('Tapped ${product['name']}');
                      },
                    );
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

 }