import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../gen/assets.gen.dart';

class SignUpHeader extends StatelessWidget {
  final VoidCallback? onBackTap;

  const SignUpHeader({super.key, this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -10,
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
          padding: EdgeInsets.only(top: 2.5.h, bottom: 1.h),
          child: Row(
            children: [
              GestureDetector(
                onTap: onBackTap ?? () => Navigator.pop(context),
                child: Container(
                  width: 11.w,
                  height: 11.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(width: 17.w),
              Image.asset(
                Assets.images.meter.path,
                height: 65,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
